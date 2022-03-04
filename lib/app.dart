import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/utils/constants.dart';
import 'core/utils/functions/helper.dart';
import 'core/utils/functions/services_initializer.dart';
import 'features/splashScreen/presentation/splah_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ServiceInitializer.instance.initializeFlutterFire(),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Text('Error: ${snapShot.error}'),
            );
          } else {
            return ProviderScope(
              child: MaterialApp(
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
              ),
            );
          }
        });
  }
}
