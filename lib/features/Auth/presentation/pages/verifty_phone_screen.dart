import 'dart:async';
import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/features/Auth/presentation/manager/send_code_notifier.dart';
import 'package:aquameter/features/localization/manager/app_localization.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class VerifyPhone extends HookConsumerWidget {
  final String phoneNumber, countryCode, verificationId;
  final int inx;
  VerifyPhone({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
    required this.countryCode,
    required this.inx,
  }) : super(key: key);

  final Duration defaultDuration = const Duration(minutes: 1);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SendCodeNotifier resendCode = ref.watch(sendCodeProvider.notifier);

    final StreamController<ErrorAnimationType> errorController =
        useStreamController();
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.15,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.25,
                child: Image.asset(kAppLogo),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.1,
                    bottom: SizeConfig.screenHeight * 0.05,
                    right: 10),
                child: Text(
                  localization
                      .text('please_enter_the_code_sent_via_text_message')!,
                  style: MainTheme.headingTextStyle
                      .copyWith(color: Colors.black45),
                ),
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: SizeConfig.screenWidth * 0.02),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          debugLabel: localization
                              .text('would_you_like_to_print_this_code'),
                          color: MainStyle.primaryColor,
                        ),
                        length: 6,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 4) {
                            return "I'm from validator";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          inactiveColor: MainStyle.mainGray,
                          inactiveFillColor: MainStyle.mainGray,
                          selectedFillColor: MainStyle.mainGray,
                          selectedColor: MainStyle.mainGray,
                          activeColor: MainStyle.mainGray,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15),
                          fieldHeight: 50,
                          fieldWidth: SizeConfig.screenWidth * 0.15,
                          activeFillColor: MainStyle.mainGray,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        textStyle: const TextStyle(fontSize: 20, height: 1.6),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        keyboardType: TextInputType.number,
                        enablePinAutofill: true,
                        onCompleted: (v) async {
                          debugPrint(v);
                          await ref
                              .read(sendCodeProvider.notifier)
                              .verfiyCode(verificationId, v, context, inx);
                        },
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          debugPrint('Allowing to paste $text');
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    )),
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SlideCountdown(
                          key: ValueKey(resendCode.value),
                          onDone: () {
                            ref.refresh(sendCodeProvider.notifier).resendCode();
                          },
                          duration: defaultDuration,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          fade: true,
                          durationTitle: DurationTitle.id(),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: MainStyle.primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.05,
                    ),
                    Visibility(
                      visible: resendCode.resend,
                      child: InkWell(
                        onTap: () async {
                          await ref
                              .read(sendCodeProvider.notifier)
                              .sendCode(context, countryCode, phoneNumber, inx);
                        },
                        child: Text(
                          localization.text('resend_the_code')!,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
            onPressed: () {
              pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ]),
      ),
    );
  }
}
