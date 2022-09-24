import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/services/localization_service.dart';
import 'package:aquameter/features/Auth/presentation/pages/change_pass_screen.dart';
import 'package:aquameter/features/Drawer/presentation/pages/about_us.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/utils/routing/navigation_service.dart';
import '../../core/utils/services/storage_service.dart';
import '../../core/utils/sizes.dart';
import '../localization/presentation/manager/app_locale_provider.dart';
import '../archieve/presentation/pages/archieve.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../localization/presentation/widgets/select_language.dart';
import 'drawer_item.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> data = ["English", "Arabic"];
_sendWhatsApp() async {
  Uri url = Uri.parse("whatsapp://send?phone=201069072590");
  await canLaunchUrl(url) ? launchUrl(url) : debugPrint('No WhatsAPP');
}

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocaleNotifier appLocal = ref.watch(appLocaleProvider.notifier);
    return Container(
      padding: appLocal.languageType == 'en'
          ? const EdgeInsets.only(left: 20)
          : const EdgeInsets.only(right: 15),
      margin: EdgeInsets.only(
          top: Sizes.mainDrawerHPadding(context) * 2,
          bottom: Sizes.mainDrawerVPadding(context)),
      width: Sizes.mainDrawerWidth(context),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: appLocal.languageType == 'en'
              ? const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              StorageService.instance.restoreUserData().data!.name!,
              style: MainTheme.subTextStyle.copyWith(color: Colors.black26),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          DrwaerItem(
              widget: const Icon(Icons.archive),
              text: tr(context).archieve,
              onTap: () => NavigationService.push(context,
                  page: ArcieveScreen(), isNamed: false)),
          DrwaerItem(
              widget: const Icon(Icons.password),
              text: tr(context).change_password,
              onTap: () => NavigationService.push(context,
                  page: const ChangePassScreen(), isNamed: false)),
          DrwaerItem(
            widget: const Icon(Icons.settings),
            text: tr(context).selected_language,
            onTap: () =>
                SelectLanguage.show(context: context, appLocal: appLocal),
          ),
          DrwaerItem(
              widget: const ImageIcon(AssetImage('assets/images/polices.png')),
              text: tr(context).about,
              onTap: () {
                NavigationService.push(context,
                    page: AboutAndTerms(
                      isAbout: true,
                      title: tr(context).about,
                    ),
                    isNamed: false);
              }),
          DrwaerItem(
              widget: const ImageIcon(AssetImage('assets/images/contact.png')),
              text: tr(context).contact_us,
              onTap: _sendWhatsApp),
          DrwaerItem(
              widget: const ImageIcon(AssetImage('assets/images/polices.png')),
              text: tr(context).terms_of_Services,
              onTap: () {
                NavigationService.push(context,
                    page: AboutAndTerms(
                      isAbout: false,
                      title: tr(context).terms_of_Services,
                    ),
                    isNamed: false);
              }),
          DrwaerItem(
              widget: const Icon(Icons.share_outlined),
              text: tr(context).share_app,
              onTap: () {
                Theme.of(context).platform != TargetPlatform.iOS
                    ? shareTheApp(context,
                        'https://play.google.com/store/apps/details?id=com.food_menu.food_menu')
                    : shareTheApp(context, '');
              }),
          DrwaerItem(
              widget: const Icon(Icons.logout),
              text: tr(context).logOut,
              onTap: () async {
                StorageService.instance.logOut(context);
              }),
        ],
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
