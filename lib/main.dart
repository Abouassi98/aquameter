import 'dart:async';
import 'dart:io';

import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'features/localization/manager/app_localization.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message: ${message.messageId}');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    await FCMConfig.instance
        .init(
      onBackgroundMessage: _firebaseMessagingBackgroundHandler,
      alert: true,
      announcement: true,
      badge: true,
      displayInForeground: true,
      carPlay: false,
      criticalAlert: true,
      defaultAndroidForegroundIcon:
          '@mipmap/ic_launcher', //default is @mipmap/ic_launcher
      defaultAndroidChannel: const AndroidNotificationChannel(
        'my_channel', // same as value from android setup
        'Your app name',
        importance: Importance.high,
        // sound: RawResourceAndroidNotificationSound('notification'),// دي لو عتدك الصوت فعلا
      ),
      provisional: false,
      sound: true,
    )
        .then((value) {
      FCMConfig.instance.messaging.subscribeToTopic('test_fcm_topic');
    });
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    await localization.init();
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(
        Phoenix(
          child: const MyApp(),
        ),
      );
    });
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
