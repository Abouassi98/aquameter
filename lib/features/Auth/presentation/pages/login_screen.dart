import 'dart:developer';

import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/convert_arabic_numbers_to_english_number.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';

import 'package:aquameter/core/utils/widgets/custom_country_code_picker.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Auth/presentation/manager/auth_notifier.dart';
import 'package:aquameter/features/Auth/presentation/pages/send_code_screen.dart';

import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  final _form = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  final List<String> acceptedNumbers = [
    '012',
    '011',
    '015',
    '010',
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String phone = '', countryCode = '+20', password = '';
    final AuthNotifier login = ref.watch(loginProvider.notifier);
    final ValueNotifier<bool> visabilityNotifier = useState<bool>(true);
    return Scaffold(
      body: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              kAppLogo,
              height: SizeConfig.screenHeight * 0.2,
              width: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              numbersOnly: true,
              width: SizeConfig.screenWidth * 0.7,
              icon: Icons.phone,
              showCounterTxt: true,
              hint: "رقم الموبايل",
              maxLength: 11,
              validator: (v) {
                bool phoneNumberAccepted = false;
                if (v!.length < 11) {
                  return 'رقم هاتف قصير';
                }
                for (String char in acceptedNumbers) {
                  phoneNumberAccepted = v.startsWith(char);
                  if (phoneNumberAccepted) {
                    break;
                  }
                }
                if (phoneNumberAccepted == false) {
                  return 'رقم هاتف غير صالح';
                }
                log(
                  phoneNumberAccepted.toString(),
                );
              },
              suffixIcon: CustomCountryCodePicker(
                onChange: (Country value) {
                  countryCode = '+' '${value.phoneCode}';
                },
              ),
              onChange: (v) {
                phone = convertToEnglishNumbers(v.trim());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              width: SizeConfig.screenWidth * 0.7,
              icon: Icons.lock,
              hint: "كلمة السر",
              onChange: (v) {
                password = v;
              },
              validator: (v) {
                if (v!.isEmpty) {
                  return ' يجب ملئ الحقل';
                }
                return null;
              },
              visibility: visabilityNotifier.value,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(6),
                child: IconButton(
                  icon: Icon(visabilityNotifier.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    visabilityNotifier.value = !visabilityNotifier.value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomTextButton(
              title: 'تسجيل الدخول',
              function: () async {
                final isValid = _form.currentState!.validate();
                if (!isValid) {
                  return;
                }
                _form.currentState!.save();
                login.login(context, phone, password);
              },
              radius: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: TextButton(
                child: const Text(' نسيت كلمة السر ؟ ',
                    style: TextStyle(color: Colors.black, fontSize: 15.0)),
                onPressed: () {
                  push(
                    SendCodeScreen(inx: 1),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
