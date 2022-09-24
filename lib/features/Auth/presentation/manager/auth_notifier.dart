import 'dart:developer';
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/services/storage_service.dart';

final StateNotifierProvider<AuthNotifier, Object?> loginProvider =
    StateNotifierProvider(
  (ref) => AuthNotifier(ref),
);

class AuthNotifier extends StateNotifier<void> {
  AuthNotifier(this.ref) : super(null);

  final NetworkUtils _utils = NetworkUtils();
  final Ref ref;
  Future<void> login(
    BuildContext context,
    String phone,
    String password,
  ) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'loading progress');

    Response response = await _utils.requstData(
      body: {
        'phone': phone,
        'password': password,
      },
      url: 'login',
    );

    if (response.statusCode == 200) {
      await StorageService.instance.saveUserData(value: response.data);

      await StorageService.instance.saveData(
        value: response.data['token'],
        key: kToken,
        dataType: DataType.string,
      );
      pd.close();

      NavigationService.pushReplacementAll(NavigationService.context,
          page: const MainPage(), isNamed: false);

      ref.read(fishTypesNotifier.notifier).getFishTypes();
      ref.read(areaAndCitesNotifier.notifier).getCities();
    } else {
      pd.close();
    }
  }

  Future<void> fetchUserData() async {
    Response response = await _utils.requstData(
      get: true,
      url: 'profile',
    );
    if (response.statusCode == 200) {
      await StorageService.instance.saveUserData(value: response.data);
      log('Token >>> ${StorageService.instance.restoreToken()}');
      ref.read(fishTypesNotifier.notifier).getFishTypes();
      ref.read(areaAndCitesNotifier.notifier).getCities();
      NavigationService.pushReplacementAll(NavigationService.context,
          page: const MainPage(), isNamed: false);
    } else {}
  }
}
