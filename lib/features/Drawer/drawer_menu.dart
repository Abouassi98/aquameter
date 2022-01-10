import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/features/Auth/presentation/pages/change_pass_screen.dart';

import 'package:aquameter/features/Drawer/presentation/pages/about_us.dart';
import '../archieve/presentation/pages/archieve.dart';
import 'package:aquameter/features/localization/manager/app_localization.dart';
import 'package:aquameter/features/localization/screen/language_select.dart';
import 'package:aquameter/features/splashScreen/presentation/splah_view.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:share/share.dart';

import '../../core/utils/size_config.dart';

import 'drawer_item.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);
  _sendWhatsApp() async {
    var url = "https://wa.me/+201069072590";
    await canLaunch(url) ? launch(url) : debugPrint('No WhatsAPP');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Container(
        padding: Localizations.localeOf(context).languageCode == 'en'
            ? const EdgeInsets.only(right: 15)
            : const EdgeInsets.only(left: 15),
        margin: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.04,
            bottom: SizeConfig.screenHeight * 0.09),
        width: SizeConfig.screenWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: localization.currentLanguage.toString() == 'en'
              ? const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50))
              : const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                HelperFunctions.getUser().data!.name!,
                style: MainTheme.subTextStyle.copyWith(color: Colors.black26),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            DrwaerItem(
              widget: const Icon(Icons.archive),
              text: localization.text('archieve')!,
              onTap: () => push(
                ArcieveScreen(
                  title: localization.text('archieve')!,
                ),
              ),
            ),
            DrwaerItem(
              widget: const Icon(Icons.password),
              text: 'تغير كلمة المرور',
              onTap: () => push(const ChangePassScreen()),
            ),
            DrwaerItem(
                widget: const Icon(Icons.settings),
                text: localization.text('change_language')!,
                onTap: () => push(const LanguageSelect())),
            DrwaerItem(
                widget:
                    const ImageIcon(AssetImage('assets/images/polices.png')),
                text: localization.text('about')!,
                onTap: () {
                  push(AboutUs(
                    title: localization.text('about')!,
                  ));
                }),
            DrwaerItem(
                widget:
                    const ImageIcon(AssetImage('assets/images/contact.png')),
                text: localization.text('contact_us')!,
                onTap: _sendWhatsApp),
            DrwaerItem(
                widget:
                    const ImageIcon(AssetImage('assets/images/polices.png')),
                text: localization.text('terms_and_conditions')!,
                onTap: () {
                  push(AboutUs(
                    title: localization.text('terms_and_conditions')!,
                  ));
                }),
            DrwaerItem(
                widget: const Icon(Icons.share_outlined),
                text: localization.text('share_app')!,
                onTap: () {
                  Theme.of(context).platform != TargetPlatform.iOS
                      ? shareTheApp(context,
                          'https://play.google.com/store/apps/details?id=com.food_menu.food_menu')
                      : shareTheApp(context, '');
                }),
            DrwaerItem(
                widget: const Icon(Icons.logout),
                text: localization.text('logout')!,
                onTap: () async {
                  await GetStorage.init().then((value) async {
                    await GetStorage().remove(kcashedUserData);
                    await GetStorage().remove(kIsLoggedIn);
                  });
                  pushAndRemoveUntil(const SplashView());
                }),
          ],
        ),
      ),
    );
  }

  shareTheApp(BuildContext context, String url) async {
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share(
        'لتنزيل التطبيق اضغط على الرابط التالي \n https://play.google.com/store/apps/details?id=com.food_menu.food_menu',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
