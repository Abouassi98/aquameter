import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app.dart';
import 'core/utils/services/services_initializer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  debugPrint('Handling a background message: ${message.messageId}');
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
        'high_importance_channel', // same as value from android setup
        'AquaMeter',
        importance: Importance.high,
        // sound: RawResourceAndroidNotificationSound('notification'),// دي لو عتدك الصوت فعلا
      ),
      provisional: false,
      sound: true,
    )
        .then((value) {
      FCMConfig.instance.messaging.getToken().then((token) {
        debugPrint('device token >>>$token');
      });
      // FCMConfig.messaging.subscribeToTopic('test_fcm_topic');
    });
    final container = ProviderContainer();
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    await ServicesInitializer.instance.init(widgetsBinding, container);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(
      UncontrolledProviderScope(container: container, child: const MyApp()),
    );
  },
      (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack,
          reason: 'a fatal error',
          // Pass in 'fatal' argument
          fatal: true));
}
