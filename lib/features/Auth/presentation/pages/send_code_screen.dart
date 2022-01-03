import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/convert_arabic_numbers_to_english_number.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_country_code_picker.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/localization/manager/app_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';

// forgetPassword=1>>changePassword=2
class SendCodeScreen extends ConsumerWidget {
  final int inx;
  SendCodeScreen({Key? key, required this.inx}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String phone = '', countryCode = '+20';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.25,
                        child: Image.asset(kAppLogo),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.1,
                              bottom: SizeConfig.screenHeight * 0.05,
                              right: 10),
                          child: Text(
                            localization.text(
                                'please_enter_your_phone_number_to_send_code')!,
                            style: MainTheme.headingTextStyle
                                .copyWith(color: Colors.black45),
                          ),
                        ),
                        
                      ),
                    ],
                  ),
                  Center(
                    child: CustomTextField(
                      icon: Icons.phone,
                        showCounterTxt: true,
                      hint: "رقم الموبايل",
                      width: SizeConfig.screenWidth * 0.7,
                      maxLength: 11,
                      numbersOnly: true,
                      suffixIcon: CustomCountryCodePicker(
                        onChange: (Country value) {
                          countryCode = '+' '${value.phoneCode}';
                          debugPrint(countryCode);
                        },
                      ),
                      onChange: (v) {
                        phone = convertToEnglishNumbers(v.trim());
                        if (v.startsWith('0')) {
                          phone = v.substring(1, v.length);
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CustomTextButton(
                        title: localization.text('send'),
                        radius: 20,
                        function: () async {
                          final bool isVaild =
                              _formKey.currentState!.validate();
                          if (isVaild) {
                            await ref
                                .read(sendCodeProvider.notifier)
                                .sendCode(context, countryCode, phone, inx);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
              onPressed: () {
                pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ],
        ),
      ),
    );
  }
}
