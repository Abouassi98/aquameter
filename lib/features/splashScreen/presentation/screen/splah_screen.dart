import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/hooks/fade_in_controller_hook.dart';
import '../../../../core/screens/popup_page.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/sizes.dart';

import '../../manager/splash_provider.dart';

final fadeController = useFadeInController();

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(splashProvider);

    return PopUpPage(
      body: FadeIn(
        curve: Curves.easeIn,
        controller: fadeController,
        child: Center(
          child: Image.asset(
            kAppLogo,
            height: Sizes.fullScreenHeight(context),
            width: Sizes.fullScreenWidth(context),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
