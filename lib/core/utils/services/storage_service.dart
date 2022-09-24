import 'dart:convert';

import 'package:aquameter/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/Auth/data/user_model.dart';
import '../../../features/Auth/presentation/pages/login_screen.dart';
import '../routing/navigation_service.dart';

enum DataType {
  string,
  int,
  double,
  bool,
  stringList,
}

class StorageService {
  StorageService._();

  static final instance = StorageService._();

  late final bool hasHistory;
  late SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
    //initHasHistory();
  }

  /*initHasHistory() async {
    hasHistory =
        await restoreData(key: 'has_history', dataType: DataType.bool) ?? false;
    log('hasHistory: ' + hasHistory.toString());
    if (!hasHistory){
      saveData(key: 'has_history', value: true, dataType: DataType.bool);
    }
  }*/

  saveData({
    required String key,
    required dynamic value,
    required DataType dataType,
  }) async {
    await _getSharedPrefsMethod(
      restoring: false,
      sharedPrefsMethod: dataType,
    )(key, value);
  }

  saveUserData({
    required dynamic value,
  }) async {
    String encodedMap = json.encode(value);
    await _prefs.setString(kcashedUserData, encodedMap);
  }

  Future<dynamic> restoreData({
    required String key,
    required DataType dataType,
  }) async {
    return await _getSharedPrefsMethod(
      restoring: true,
      sharedPrefsMethod: dataType,
    )(key);
  }

  String restoreToken() {
    return _prefs.getString(kToken)!;
  }

  

  UserModel restoreUserData() {
    String? encodedMap = _prefs.getString(kcashedUserData);
    final user = encodedMap != null ? json.decode(encodedMap) : null;
    return UserModel.fromJson(user ?? {});
  }

  Future<bool> clearAll() async {
    return await _prefs.clear();
  }

  Future logOut(BuildContext context) async {
    await _prefs.remove(kcashedUserData);
    await _prefs.remove(kIsLoggedIn);
    NavigationService.pushAndRemoveUntil(
    NavigationService.context,
        page:  const LoginScreen(),
        predicate: (_) => false,
        fullscreenDialog: true);
  }

  Future<bool> clearKey({required key}) async {
    return await _prefs.remove(key);
  }

  _getSharedPrefsMethod(
      {required bool restoring, required DataType sharedPrefsMethod}) {
    switch (sharedPrefsMethod) {
      case DataType.bool:
        {
          return restoring ? _prefs.getBool : _prefs.setBool;
        }
      case DataType.string:
        {
          return restoring ? _prefs.getString : _prefs.setString;
        }
      case DataType.double:
        {
          return restoring ? _prefs.getBool : _prefs.setBool;
        }
      case DataType.int:
        {
          return restoring ? _prefs.getInt : _prefs.setInt;
        }
      case DataType.stringList:
        {
          return restoring ? _prefs.getStringList : _prefs.setStringList;
        }
      default:
        {
          throw 'No method was selected, method is required';
        }
    }
  }
}
