import 'dart:developer';
import 'package:aquameter/core/screens/popup_page.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/convert_arabic_numbers_to_english_number.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Auth/presentation/manager/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/services/localization_service.dart';
import '../../../../core/utils/sizes.dart';

_sendWhatsApp() async {
  Uri url = Uri.parse("whatsapp://send?phone=201069072590");
  await canLaunchUrl(url) ? launchUrl(url) : debugPrint('No WhatsAPP');
}

final List<String> acceptedNumbers = [
  '012',
  '011',
  '015',
  '010',
];
final loginFormKey = useMemoized(() => GlobalKey<FormState>());
final StateProvider<bool> visabilityNotifierProvider =
    StateProvider<bool>((ref) => true);

String phone = '', password = '';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool visabilityNotifier = ref.watch(visabilityNotifierProvider);

    return PopUpPage(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: loginFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                kAppLogo,
                height: Sizes.pickedImageMaxSize(context),
                fit: BoxFit.fill,
              ),
              CustomTextField(
                numbersOnly: true,
                type: TextInputType.phone,
                width: Sizes.fullScreenWidth(context) * 0.7,
                icon: Icons.phone,
                showCounterTxt: true,
                hint: tr(context).phone,
                maxLength: 11,
                validator: (v) {
                  bool phoneNumberAccepted = false;
                  if (v!.length < 11) {
                    return tr(context).short_phone_number;
                  }
                  for (String char in acceptedNumbers) {
                    phoneNumberAccepted = v.startsWith(char);
                    if (phoneNumberAccepted) {
                      break;
                    }
                  }
                  if (phoneNumberAccepted == false) {
                    return tr(context).invalid_phone_number;
                  }
                  log(
                    phoneNumberAccepted.toString(),
                  );
                  return null;
                },
                onChange: (v) {
                  phone = convertToEnglishNumbers(v.trim());
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                height: Sizes.fullScreenHeight(context) * .09,
                width: Sizes.fullScreenWidth(context) * 0.7,
                icon: Icons.lock,
                hint: tr(context).password,
                onChange: (v) {
                  password = v;
                },
                validator: (v) {
                  if (v!.isEmpty) {
                    return tr(context).the_field_should_not_be_left_blank;
                  }
                  return null;
                },
                visibility: visabilityNotifier,
                suffixIcon: IconButton(
                  icon: Icon(visabilityNotifier
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    ref.read(visabilityNotifierProvider.state).state =
                        !visabilityNotifier;
                  },
                ),
              ),
              const SizedBox(height: 30),
              CustomTextButton(
                title: tr(context).login,
                function: () async {
                  final isValid = loginFormKey.currentState!.validate();
                  if (!isValid) {
                    return;
                  }
                  loginFormKey.currentState!.save();

                  ref.read(loginProvider.notifier).login(
                        context,
                        phone,
                        password,
                      );
                },
              ),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text(tr(context).forget_password,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 15.0)),
                  onPressed: () {
                    _sendWhatsApp();
                    // push(
                    //   SendCodeScreen(inx: 1),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
