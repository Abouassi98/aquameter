import 'dart:developer';
import 'package:aquameter/core/utils/functions/convert_arabic_numbers_to_english_number.dart';

import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/features/Auth/presentation/pages/forget_pass_screen.dart';
import 'package:aquameter/features/Auth/presentation/pages/verifty_phone_screen.dart';
import 'package:aquameter/features/localization/manager/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SendCodeNotifier extends StateNotifier<void> {
  SendCodeNotifier(void state) : super(state);
  bool resend = false;
  int value = 1;
  String phoneNumber = '';

  final List<String> acceptedNumbers = [
    '78',
    '75',
    '77',
    '79',
    '12',
    '11',
    '15',
    '10',
  ];
  void resendCode() {
    resend = true;
    value++;
    debugPrint('resend=$resend');
    debugPrint('value=$value');
  }

  Future<void> sendCode(
    BuildContext context,
    String countryCode,
    String phone,
    int inx,
  ) async {
    try {
      bool phoneNumberAccepted = false;
      debugPrint('Gideon test 1');
      phoneNumber = convertToEnglishNumbers(phone);
      debugPrint('Gideon test 2');

      if (phoneNumber.startsWith('0')) {
        phoneNumber = phoneNumber.substring(1, phoneNumber.length);
      }
      for (String char in acceptedNumbers) {
        phoneNumberAccepted = phoneNumber.startsWith(char);
        log(phoneNumberAccepted.toString());
        if (phoneNumberAccepted) {
          break;
        }
      }
      debugPrint('phoneNumber =$countryCode$phoneNumber');

      if (phoneNumberAccepted) {
        if (phoneNumber.length == 10) {
          ProgressDialog pd = ProgressDialog(context: context);
          pd.show(max: 100, msg: 'loading progress');
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '$countryCode$phoneNumber',
            verificationCompleted: (PhoneAuthCredential credential) async {
              debugPrint('Gideon test 3');
              await FirebaseAuth.instance.signInWithCredential(credential);

              //auto code complete (not manually)
            },
            verificationFailed: (FirebaseAuthException error) {
              debugPrint('Gideon test 5' + error.message!);
            },
            codeSent: (verificationId, [forceResendingToken]) async {
              debugPrint('Gideon test 6');

              push(
                VerifyPhone(
                  phoneNumber: phoneNumber,
                  verificationId: verificationId,
                  countryCode: countryCode,
                  inx: inx,
                ),
              );
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              debugPrint('Gideon test 7');
            },
            timeout: const Duration(seconds: 60),
          );
          pd.close();
          debugPrint('Gideon test 8');
        } else {
         HelperFunctions.errorBar(context,
              message: localization.text('invalid_phone_number')!,
              duration: const Duration(seconds: 10),
              );
        }
      } else {
         HelperFunctions.errorBar(context,
            message: localization.text('invalid_phone_number')!,
            duration: const Duration(seconds: 10),
           );
      }
    } on FirebaseException catch (e) {
       HelperFunctions.errorBar(context,
          message: e.message!,
          duration: const Duration(seconds: 10),
         );
    }
  }

  Future<void> verfiyCode(
    String verificationId,
    String smsCode,
    BuildContext context,
    int inx,
  ) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'loading progress');
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    await FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then(
          (user) async => {
            pd.close(),
            if (inx == 1)
              {
                push(
                  const ForgetPassScreen(),
                ),
              }
            else if (inx == 2)
              {
                // push(
                //   const ChangePassScreen(),
                // )
              }
          },
        )
        .catchError((e) {
       HelperFunctions.errorBar(context,
          message: e.message!,
          duration: const Duration(seconds: 10),
          );
    });
  }
}
