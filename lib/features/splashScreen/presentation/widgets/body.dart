import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/widgets/image_bg.dart';
import 'package:aquameter/features/Auth/presentation/pages/login_screen.dart';
import 'package:aquameter/features/localization/screen/language_select.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashViewBody extends HookConsumerWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    determinePage();
    return const ImageBG(
      network: false,
      image: kAppLogo,
      width: double.infinity,
      height: double.infinity,
    );
  }

  void determinePage() async {
    bool isFirstTime = GetStorage().read(kIsFirstTime) ?? true;

    if (isFirstTime) {
      Future.delayed(const Duration(seconds: 0), () async {
        pushAndRemoveUntil(const LanguageSelect());
      });
    } else {
      bool isLoggedIn = GetStorage().read(kIsLoggedIn) ?? false;

      if (isLoggedIn) {
        //   await changeLanguage.fetchUserData();
      } else {
        Future.delayed(const Duration(seconds: 0), () async {
          pushAndRemoveUntil(LoginScreen());
        });
      }
    }
  }
}
