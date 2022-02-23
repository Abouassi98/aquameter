import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/functions/helper.dart';
import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../Home/presentation/pages/main_page.dart';
import '../../data/change_pass_model.dart';

class ChangePassNotifier extends StateNotifier<void> {
  ChangePassNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();

  ChangePassModel? _model;

  changepassword({
    required String currentPassword,
    required String newPassword,
    required String confPass,
  }) async {
    Response response = await _utils.requstData(
      url: 'editProfile',
      body: {
        'current_password': currentPassword,
        'password': newPassword,
        'confirm_password': confPass,
      },
    );
    _model = ChangePassModel.fromJson(response.data);
    if (response.statusCode == 200) {
      log('password changed');
      pushAndRemoveUntil(const MainPage());

      return _model;
    } else {
      log('error ');
    }
  }
}
