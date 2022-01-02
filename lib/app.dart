import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/utils/constants.dart';
import 'core/utils/functions/helper.dart';
import 'core/utils/providers.dart';
import 'features/splashScreen/presentation/splah_view.dart';

const _kShouldTestAsyncErrorOnInit = false;

// Toggle this for testing Crashlytics in your app locally.
const _kTestingCrashlytics = true;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  Future<void> _initializeFlutterFire() async {
    await Firebase.initializeApp();
    // Wait for Firebase to initialize

    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    // Pass all uncaught errors to Crashlytics.
    FlutterExceptionHandler? originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError!(errorDetails);
    };

    if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }
  }

  Future<void> _testAsyncErrorOnInit() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      final List<int> list = <int>[];
      debugPrint(list[100].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeFlutterFire(),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Text('Error: ${snapShot.error}'),
            );
          } else {
            return ProviderScope(
              child: Consumer(
                builder: (_, watch, __) {
                  watch.watch(languageProvider);
                  return MaterialApp(
                    useInheritedMediaQuery: true, // Set to true_device_preview
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en', 'USA'),
                      Locale('ar', 'SA'),
                    ],

                    debugShowCheckedModeBanner: false,
                    title: 'AquaMeter',
                    navigatorKey: navigator,
                    theme: appTheme,
                    home: const SplashView(),
                  );
                },
              ),
            );
          }
        });
  }
}
