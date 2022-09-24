import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/services/storage_service.dart';

final StateNotifierProvider<AppLocaleNotifier, Locale?> appLocaleProvider =
    StateNotifierProvider<AppLocaleNotifier, Locale?>((ref) {
  return AppLocaleNotifier();
});

class AppLocaleNotifier extends StateNotifier<Locale?> {
  AppLocaleNotifier() : super(null);
  String get languageType => _languageType;
  String _languageType = 'ar';
  init() async {
    await getUserStoredLocale();
    setTimeAgoLocales();
  }

  getUserStoredLocale() async {
    final appLocale = await StorageService.instance.restoreData(
      key: kLocale,
      dataType: DataType.string,
    );

    _languageType = appLocale != null ? Locale(appLocale!).languageCode : 'ar';
    state = appLocale != null ? Locale(appLocale!) : const Locale('ar', '');
  }

  setTimeAgoLocales() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
  }

  changeLocale({required String languageCode}) {
    _languageType = languageCode;
    state = Locale(languageCode);
    setUserStoredLocale(languageCode: languageCode);
  }

  Future setUserStoredLocale({required String languageCode}) async {
    await StorageService.instance.saveData(
      value: languageCode,
      key: kLocale,
      dataType: DataType.string,
    );
  }
}
