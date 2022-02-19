import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import 'package:aquameter/features/Auth/presentation/manager/auth_notifier.dart';
import 'package:aquameter/features/Auth/presentation/manager/change_pass_notifier.dart';

import 'package:aquameter/features/CustomMap/presentation/manager/map_notifier.dart';
import 'package:aquameter/features/Home/presentation/manager/graph_statics_notifier.dart';
import 'package:aquameter/features/Home/presentation/manager/plan_of_week_notifier.dart';
import 'package:aquameter/features/Home/presentation/manager/get_&_delete_clients_create_metting_&_period_notifier.dart';
import 'package:aquameter/features/Home/presentation/manager/three_values_notifier.dart';
import 'package:aquameter/features/archieve/presentation/manager/archieve_notifier.dart';
import 'package:aquameter/features/calculator/presentation/manager/create_meeting_result_notifier.dart';

import 'package:aquameter/features/localization/manager/change_language_provider.dart';
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';


import 'package:aquameter/features/profileClient/presentation/manager/meeting_all_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/manager/update_and_endperiod_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/Drawer/manager/about_terms_notifier.dart';

// general
StateNotifierProvider<ChangeLanguageProvider, Object?> languageProvider =
    StateNotifierProvider(
  (ref) => ChangeLanguageProvider(null),
);
final AutoDisposeStateNotifierProvider<PlanOfWeekNotifier, Object?>
    departMentProvider = StateNotifierProvider.autoDispose(
  (ref) => PlanOfWeekNotifier(null),
);
final StateNotifierProvider<MapNotifier, Object?> mapNotifier =
    StateNotifierProvider(
  (ref) => MapNotifier(null),
);
final StateNotifierProvider<AreaAndCitesNotifier, Object?>
    areaAndCitesNotifier = StateNotifierProvider(
  (ref) => AreaAndCitesNotifier(null),
);
final StateNotifierProvider<FishTypesNotifier, Object?> fishTypesNotifier =
    StateNotifierProvider(
  (ref) => FishTypesNotifier(null),
);

final StateNotifierProvider<AuthNotifier, Object?> loginProvider =
    StateNotifierProvider(
  (ref) => AuthNotifier(null),
);
final StateNotifierProvider<AddClientNotifier, Object?> addClientNotifier =
    StateNotifierProvider(
  (ref) => AddClientNotifier(null),
);
final StateNotifierProvider<GetAndDeleteClientsCreateMettingAndPeriodNotifier,
        Object?> getClientsNotifier =
    StateNotifierProvider<GetAndDeleteClientsCreateMettingAndPeriodNotifier,
        Object?>(
  (ref) => GetAndDeleteClientsCreateMettingAndPeriodNotifier(),
);

final AutoDisposeStateNotifierProvider<MeetingAllNotifier, Object?>
    meetingAllNotifier =
    StateNotifierProvider.autoDispose<MeetingAllNotifier, Object?>(
  (ref) => MeetingAllNotifier(null),
);
final AutoDisposeStateNotifierProvider<GraphStaticsNotifer, Object?>
    graphStaticsNotifer =
    StateNotifierProvider.autoDispose<GraphStaticsNotifer, Object?>(
  (ref) => GraphStaticsNotifer(),
);

final AutoDisposeStateNotifierProvider<GetArchiveNotifier, Object?>
    getArchiveNotifier =
    StateNotifierProvider.autoDispose<GetArchiveNotifier, Object?>(
  (ref) => GetArchiveNotifier(),
);

final StateNotifierProvider<UpdateAndDeletePeriodNotifier, Object?>
    updateAndDeletePeriodNotifier =
    StateNotifierProvider<UpdateAndDeletePeriodNotifier, Object?>(
  (ref) => UpdateAndDeletePeriodNotifier(null),
);
final StateNotifierProvider<CreateMeetingResultNotifier, Object?>
    createMeetingResultNotifier =
    StateNotifierProvider<CreateMeetingResultNotifier, Object?>(
  (ref) => CreateMeetingResultNotifier(null),
);
final StateNotifierProvider<GetThreeValuesNotifier, Object?>
    getThreeValuesNotifier =
    StateNotifierProvider<GetThreeValuesNotifier, Object?>(
  (ref) => GetThreeValuesNotifier(),
);
final StateNotifierProvider<GetAboutAndTermsNotifier, Object?>
    getAboutAndTermsNotifier =
    StateNotifierProvider<GetAboutAndTermsNotifier, Object?>(
  (ref) => GetAboutAndTermsNotifier(),
);

final StateNotifierProvider<ChangePassNotifier, Object?> changePassProvider =
    StateNotifierProvider((ref) => ChangePassNotifier(null));
