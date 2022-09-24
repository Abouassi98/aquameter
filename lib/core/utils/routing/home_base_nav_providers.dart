import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'navigator_route_observer.dart';
import 'route_paths.dart';

class HomeBaseNavProviders {
  static final currentIndex = StateProvider.autoDispose<int>((ref) => 1);

  static final routes = [

    StateProvider.autoDispose<String>((ref) => RoutePaths.home),
    StateProvider.autoDispose<String>((ref) => RoutePaths.statics),
  ];

  static final routeObservers = [
    Provider.autoDispose<NavigatorRouteObserver>(
      (ref) => NavigatorRouteObserver(
        routesStackCallBack: (List<Route> route) {
          ref.watch(routes[0].notifier).state = route.last.settings.name!;
        },
      ),
    ),
    Provider.autoDispose<NavigatorRouteObserver>(
      (ref) => NavigatorRouteObserver(
        routesStackCallBack: (List<Route> route) {
          ref.watch(routes[1].notifier).state = route.last.settings.name!;
        },
      ),
    ),
  ];
}
