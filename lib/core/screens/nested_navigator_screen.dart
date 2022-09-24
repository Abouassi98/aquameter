
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/routing/home_base_nav_utils.dart';
import '../utils/routing/home_base_nav_providers.dart';

class NestedNavigatorScreen extends ConsumerWidget {
  final int index;
  final String screenPath;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;

  const NestedNavigatorScreen({
    required this.index,
    required this.screenPath,
    required this.onGenerateRoute,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final navRouteObserver =
        ref.watch(HomeBaseNavProviders.routeObservers[index]);

    return Navigator(
      key: HomeBaseNavUtils.navScreensKeys[index],
      initialRoute: screenPath,
      onGenerateRoute: onGenerateRoute,
      observers: [
        navRouteObserver,
      ],
    );
  }
}
