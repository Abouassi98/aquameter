import 'package:aquameter/core/screens/popup_page.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Auth/presentation/manager/change_pass_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/services/localization_service.dart';
import '../../../../core/utils/sizes.dart';

class ChangePassScreen extends HookConsumerWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? password;
    String? confPassword;
    String? currentPassword;
    final changePassFormKey = useMemoized(() => GlobalKey<FormState>());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: PopUpPage(
        appBar: PlatformAppBar(
          title: Text(
            tr(context).change_password,
            style: MainTheme.headingTextStyle,
          ),
        ),
        body: Form(
          key: changePassFormKey,
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
                      height: Sizes.fullScreenHeight(context) * 0.04,
                    ),
                    Container(
                      width: Sizes.fullScreenWidth(context) * 0.7,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: CustomTextField(
                        onChange: (v) {
                          currentPassword = v;
                        },
                        hint: tr(context).password,
                        visibility: true,
                        type: TextInputType.text,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr(context).password_required;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: Sizes.fullScreenHeight(context) * 0.04,
                    ),
                    Container(
                      width: Sizes.fullScreenWidth(context) * 0.7,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: CustomTextField(
                        onChange: (v) {
                          password = v;
                        },
                        hint: tr(context).new_password,
                        visibility: true,
                        type: TextInputType.text,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr(context).change_password;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: Sizes.fullScreenHeight(context) * 0.04,
                    ),
                    Container(
                      width: Sizes.fullScreenWidth(context) * 0.7,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: CustomTextField(
                        onChange: (v) {
                          confPassword = v;
                        },
                        hint: tr(context).confirm_password,
                        visibility: true,
                        type: TextInputType.text,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return (tr(context).confirm_password_please);
                          } else if (confPassword != password) {
                            return tr(context).passwords_doesnot_match;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: Sizes.fullScreenHeight(context) * 0.04,
                    ),
                  ],
                ),
                Center(
                    child: CustomTextButton(
                  title: tr(context).save,
                  function: () {
                    if (changePassFormKey.currentState!.validate()) {
                      ref.read(changePassProvider.notifier).changepassword(
                            confPass: confPassword!,
                            currentPassword: currentPassword!,
                            newPassword: password!,
                          );
                    }
                  },
                  width: Sizes.fullScreenWidth(context) * 0.3,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
