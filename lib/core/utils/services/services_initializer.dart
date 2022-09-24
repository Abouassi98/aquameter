import 'package:aquameter/core/utils/services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../features/localization/presentation/manager/app_locale_provider.dart';
import '../constants.dart';
import '../routing/navigation_service.dart';
import 'connectivity_service.dart';



class ServicesInitializer {
  ServicesInitializer._();

  static final ServicesInitializer instance = ServicesInitializer._();

  late ProviderContainer container;

  init(WidgetsBinding widgetsBinding, ProviderContainer container) async {
    this.container = container;
    //Init FirebaseApp instance before runApp
    await _initFirebase();
    //This Prevent closing splash screen until we finish initializing our services.
    //App layout will be built but not displayed.
    widgetsBinding.deferFirstFrame();
    widgetsBinding.addPostFrameCallback((_) async {
      //Run any function you want to wait for before showing app layout
      //await _initializeServices(); init services at custom splash
      BuildContext? context = widgetsBinding.renderViewElement;
      if (context != null) {
        await _initializeCustomSplashImages(context);
      }
      // Closes splash screen, and show the app layout.
      widgetsBinding.allowFirstFrame();
    });
  }

  _initializeCustomSplashImages(BuildContext context) async {
    await precacheImage(const AssetImage(kAppLogo), context);
  }

  initializeServices() async {
    await _initStorageService();
    await _initLocalization();
    await _initConnectivity();

  }

  _initStorageService() async {
    await StorageService.instance.init();
  }


  _initFirebase() async {
    await Firebase.initializeApp();
  }



  _initLocalization() async {
    await container.read(appLocaleProvider.notifier).init();
  }

  _initConnectivity() async {
    container.read(connectivityService).init();
  }

  Future initializeData() async {
    List futures = [
      _cacheDefaultImages(),
    ];
    List<dynamic> result = await Future.wait<dynamic>([...futures]);
    return result;
  }

  _cacheDefaultImages() async {
    await precacheImage(const AssetImage(kAppLogo), NavigationService.context);
  }
}
