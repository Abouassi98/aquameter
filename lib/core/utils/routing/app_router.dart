import 'package:aquameter/core/utils/routing/route_paths.dart';
import 'package:aquameter/features/CustomMap/presentation/pages/custom_map_select_address.dart';
import 'package:aquameter/features/Home/presentation/pages/home.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:aquameter/features/splashScreen/presentation/screen/splah_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../../features/Auth/presentation/pages/login_screen.dart';
import '../../../features/Home/presentation/pages/statics.dart';
import '../../screens/no_internet_connection_screen.dart';
import 'home_base_nav_utils.dart';
import 'navigation_service.dart';
import 'navigation_transitions.dart';

class AppRouter {
  ///Root Navigator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Core
      case RoutePaths.coreSplash:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case RoutePaths.coreNoInternet:
        final args = settings.arguments as Map?;
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => NoInternetConnection(
            offAll: args?['offAll'],
          ),
          settings: settings,
        );

      //Auth
      case RoutePaths.authLogin:
        return NavigationFadeTransition(
          const LoginScreen(),
          settings: settings,
          transitionDuration: const Duration(seconds: 1),
        );

      //HomeBase
      case RoutePaths.homeBase:
        return NavigationFadeTransition(
          const MainPage(),
          settings: settings,
        );

      //Map
      case RoutePaths.map:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const CustomMapSelectAddress(),
          settings: settings,
        );

      default:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }

  ///Nested Navigators
  static Route<dynamic> generateHomeNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      //Home
      case RoutePaths.home:
        return NavigationFadeTransition(
          Home(),
          settings: settings,
        );
      // case RoutePaths.profile:
      //   return platformPageRoute(
      //     context: HomeBaseNavUtils.navScreensKeys[0].currentContext!,
      //     builder: (_) => ProfileClientScreen(client: null,),

      //     settings: settings,
      //   );

      default:
        return NavigationFadeTransition(
          Home(),
          settings: settings,
        );
    }
  }

  static Route<dynamic> generateStaticsNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      //Statics
      case RoutePaths.statics:
        return platformPageRoute(
          context: HomeBaseNavUtils.navScreensKeys[1].currentContext!,
          builder: (_) => const Statics(),
          settings: settings,
        );

      default:
        return platformPageRoute(
          context: HomeBaseNavUtils.navScreensKeys[1].currentContext!,
          builder: (_) => const Statics(),
          settings: settings,
        );
    }
  }

  // static Route<dynamic> generateSettingsNestedRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     //Settings
  //     case RoutePaths.settings:
  //       return platformPageRoute(
  //         context: HomeBaseNavUtils.navScreensKeys[2].currentContext!,
  //         builder: (_) => const Setting(),
  //         settings: settings,
  //       );

  //     case RoutePaths.settingsLanguage:
  //       return platformPageRoute(
  //         context: HomeBaseNavUtils.navScreensKeys[2].currentContext!,
  //         builder: (_) => const LanguageScreen(),
  //         settings: settings,
  //       );

  //     default:
  //       return platformPageRoute(
  //         context: HomeBaseNavUtils.navScreensKeys[2].currentContext!,
  //         builder: (_) => const SettingsScreen(),
  //         settings: settings,
  //       );
  //   }
  // }
}
