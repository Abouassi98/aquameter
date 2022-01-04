import 'dart:developer';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class AuthNotifier extends StateNotifier<void> {
  AuthNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();

  Future<void> login(
      BuildContext context, String phone, String password) async {

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
      HelperFunctions.saveUser(response.data);

      HelperFunctions.saveToken(response.data['token']);
      pd.close();
      pushAndRemoveUntil(const MainPage());
    } else {}
  }

  Future<void> fetchUserData() async {
    Response response = await _utils.requstData(
      get: true,
      url: 'profile/${HelperFunctions.getUser().data!.id}',
    );
    if (response.statusCode == 200) {
      HelperFunctions.saveUser(response.data);
      log('Token >>> ${GetStorage().read(kToken)}');

      pushAndRemoveUntil(const MainPage());
    } else {}
  }
}
