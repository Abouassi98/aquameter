import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import 'package:aquameter/features/Auth/presentation/manager/auth_notifier.dart';
import 'package:aquameter/features/Auth/presentation/manager/send_code_notifier.dart';
import 'package:aquameter/features/Home/presentation/manager/departments_notifier.dart';
import 'package:aquameter/features/localization/manager/change_language_provider.dart';
import 'package:aquameter/features/profile/presentation/manager/location_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// general
StateNotifierProvider<ChangeLanguageProvider, Object?> languageProvider =
    StateNotifierProvider(
  (ref) => ChangeLanguageProvider(null),
);
final AutoDisposeStateNotifierProvider<DepartMentProvider, Object?>
    departMentProvider = StateNotifierProvider.autoDispose(
  (ref) => DepartMentProvider(null),
);
final StateNotifierProvider<AreaAndCitesNotifier, Object?>
    areaAndCitesNotifier = StateNotifierProvider(
  (ref) => AreaAndCitesNotifier(null),
);
final StateNotifierProvider<FishTypesNotifier, Object?>
    fishTypesNotifier = StateNotifierProvider(
  (ref) => FishTypesNotifier(null),
);
final StateNotifierProvider<LocationProvider, Object?> locationProvider =
    StateNotifierProvider(
  (ref) => LocationProvider(null),
);
final AutoDisposeStateNotifierProvider<SendCodeNotifier, Object?>
    sendCodeProvider = StateNotifierProvider.autoDispose(
  (ref) => SendCodeNotifier(null),
);

final StateNotifierProvider<AuthNotifier, Object?> loginProvider =
    StateNotifierProvider(
  (ref) => AuthNotifier(null),
);
