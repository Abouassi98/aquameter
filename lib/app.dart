import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/utils/constants.dart';
import 'core/utils/routing/app_router.dart';
import 'core/utils/routing/navigation_service.dart';
import 'core/utils/routing/route_paths.dart';
import 'features/localization/presentation/manager/app_locale_provider.dart';
import 'l10n/l10n.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocale = ref.watch(appLocaleProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Theme(
        data: appTheme,
        child: PlatformApp(
          navigatorKey: NavigationService.navigationKey,
          useInheritedMediaQuery: true, // Set to true_device_preview
          supportedLocales: L10n.all,
          localizationsDelegates: L10n.localizationsDelegates,
          locale: appLocale,
          debugShowCheckedModeBanner: false,
          title: 'AquaMeter',
          initialRoute: RoutePaths.coreSplash,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}
