import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/network_utils.dart';

import '../../data/user_model.dart';

final StateNotifierProvider<ChangePassNotifier, Object?> changePassProvider =
    StateNotifierProvider((ref) => ChangePassNotifier(null));

class ChangePassNotifier extends StateNotifier<void> {
  ChangePassNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();

  UserModel? _model;

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
    _model = UserModel.fromJson(response.data);
    if (response.statusCode == 200) {
      log('password changed');

      return _model;
    } else {
      log('error ');
    }
  }
}
