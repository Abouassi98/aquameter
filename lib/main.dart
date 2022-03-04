import 'dart:async';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app.dart';
import 'core/utils/functions/services_initializer.dart';

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

    await ServiceInitializer.instance.initializeSettings();
    runApp(
      Phoenix(
        child: const MyApp(),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
