import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

const List<String> _supportedLanguages = [
  'en',
  'ar',
  
];

class GlobalTranslations {
  Locale? _locale;
  Map<dynamic, dynamic>? _localizedValues;
  VoidCallback? _onLocaleChangedCallback;

  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  String? text(String key) {
    return (_localizedValues == null || _localizedValues![key] == null)
        ? '$key not found'
        : _localizedValues![key];
  }

  get currentLanguage => _locale == null ? '' : _locale!.languageCode;

  get locale => _locale;

  Future<void> init([String? language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
  }

  getPreferredLanguage() async {
    return _getApplicationSavedInformation(klanguage);
  }

  setPreferredLanguage(String lang) async {
    return HelperFunctions.saveApplicationInformation(klanguage, lang);
  }

  Future<void> setNewLanguage(
      [String? newLanguage, bool saveInPrefs = false]) async {
    String? language = newLanguage;
    language ??= await getPreferredLanguage();

    if (language == '') {
      language = 'ar';
    }

    _locale = Locale(language!, '');

    String jsonContent =
        await rootBundle.loadString('assets/lang/$language.json');
    _localizedValues = json.decode(jsonContent);

    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }

    if (_onLocaleChangedCallback != null) {
      _onLocaleChangedCallback!();
    }

    return;
  }

  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  Future<String> _getApplicationSavedInformation(String name) async {
    return GetStorage().read(storageKey + name) ?? 'ar';
  }

  static final GlobalTranslations _translations =
      GlobalTranslations._internal();

  factory GlobalTranslations() {
    return _translations;
  }

  GlobalTranslations._internal();
}

GlobalTranslations localization = GlobalTranslations();
