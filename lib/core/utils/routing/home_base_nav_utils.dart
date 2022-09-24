import 'package:aquameter/core/utils/routing/app_router.dart';
import 'package:aquameter/core/utils/routing/route_paths.dart';
import 'package:flutter/material.dart';

import '../../screens/nested_navigator_screen.dart';

abstract class HomeBaseNavUtils {
  static final navScreensKeys = [
    GlobalKey<NavigatorState>(debugLabel: 'page1'),
    GlobalKey<NavigatorState>(debugLabel: 'page2'),
  ];

  static const navScreens = [
    NestedNavigatorScreen(
      index: 0,
      screenPath: RoutePaths.home,
      onGenerateRoute: AppRouter.generateHomeNestedRoute,
    ),
    //Nested Navigator for persistent bottom navigation bar
    NestedNavigatorScreen(
      index: 1,
      screenPath: RoutePaths.statics,
      onGenerateRoute: AppRouter.generateHomeNestedRoute,
    ),
  ];
}
