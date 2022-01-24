import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Auth/presentation/manager/change_pass_notifier.dart';
import 'package:aquameter/features/localization/manager/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePassScreen extends HookConsumerWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? password;
    String? confPassword;
    final ChangePassNotifier changePass =
    ref.watch(changePassProvider.notifier);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تغير كلمة المرور',
            style: MainTheme.headingTextStyle,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(30),
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),

                    Container(
                      width: SizeConfig.screenWidth * 0.7,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: CustomTextField(
                        onChange: (v) {
                          password = v;
                        },
                        hint: localization.text('new_password'),
                        visibility: true,
                        type: TextInputType.text,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return localization.text('change_pass');
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.7,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: CustomTextField(
                        onChange: (v) {
                          confPassword=v;
                        },
                        hint: localization.text('confirm_password'),
                        visibility: true,
                        type: TextInputType.text,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('من فضلك قم بتأكيد كلمة السر');
                          } else if (confPassword != password) {
                            return 'كلمة السر غير متطابقان';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                  ],
                ),
                Center(
                    child: CustomTextButton(
                  title: localization.text('save'),
                  function: () {
                    if(_formKey.currentState!.validate()){
                      changePass.changePassword(
                          confirmPassword: confPassword,
                          password: password
                      );
                    }

                  },
                  width: SizeConfig.screenWidth * 0.3,
                  radius: 20,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
