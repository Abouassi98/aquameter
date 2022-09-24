import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/utils/routing/navigation_service.dart';
import '../../../core/utils/routing/route_paths.dart';
import '../../../core/utils/services/services_initializer.dart';
import '../../../core/utils/services/storage_service.dart';
import '../../../core/viewmodels/main_core_provider.dart';

import '../../Auth/presentation/manager/auth_notifier.dart';

final splashProvider =
    Provider.autoDispose<SplashProvider>((ref) => SplashProvider(ref));

class SplashProvider {
  SplashProvider(this.ref) {
    _mainCoreProvider = ref.watch(mainCoreProvider);
    init();
  }

  final Ref ref;
  late MainCoreProvider _mainCoreProvider;
  late AuthNotifier _loginProvider;
  late String secondPage;

  init() {
    _mainCoreProvider.isConnectedToInternet().then((value) {
      if (value) {
        initializeData().whenComplete(
          () {
            NavigationService.pushReplacementAll(
              NavigationService.context,
              isNamed: true,
              page: secondPage,
            );
            if (secondPage == RoutePaths.homeBase) {
              //FirebaseMessagingService.instance.getInitialMessage();
            }
          },
        );
      } else {
        NavigationService.pushReplacementAll(
          NavigationService.context,
          isNamed: true,
          page: RoutePaths.coreNoInternet,
          arguments: {'offAll': true},
        );
      }
    });
  }

  Future initializeData() async {
    List futures = [
      Future.delayed(const Duration(milliseconds: 1000)), //Min Time of splash
      ServicesInitializer.instance.initializeServices(),

      ServicesInitializer.instance.initializeData(),
    ];
    await Future.wait<dynamic>([...futures]);
    await checkForCachedUser();
  }

  Future checkForCachedUser() async {
    if (StorageService.instance.restoreUserData().data != null) {
      _loginProvider = ref.read(loginProvider.notifier);
      await _loginProvider.fetchUserData();
      secondPage = RoutePaths.homeBase;
    } else {
      secondPage = RoutePaths.authLogin;
    }
  }
}
