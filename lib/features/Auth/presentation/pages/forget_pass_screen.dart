import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:aquameter/features/localization/manager/app_localization.dart';
import 'package:flutter/material.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Center(
                child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Image(
                  image: const AssetImage(kAppLogo),
                  width: SizeConfig.screenWidth * 0.5,
                  height: SizeConfig.screenHeight * 0.5,
                ),
                Text(
                  localization.text('please_enter_the_new_password')!,
                  style:
                      MainTheme.headingTextStyle.copyWith(color: Colors.black),
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
                    icon: (Icons.lock),
                    hint: localization.text('new_password'),
                    visibility: true,
                    onChange: (v) {},
                    // validator: (value) {

                    // },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                CustomTextButton(
                  title: localization.text('confirm'),
                  function: () {
                    pushAndRemoveUntil(const MainPage());
                  },
                  radius: 25,
                ),
              ],
            )),
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
