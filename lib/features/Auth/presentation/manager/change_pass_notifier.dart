import 'dart:developer';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ChangePassNotifier extends StateNotifier<void> {
  ChangePassNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();

  changePassword({
    String? password,
    String? confirmPassword,
    required BuildContext context,
  }) async {
    Response response = await _utils.requstData(
      url: 'editProfile',
      body: {
        'password': password,
        'confirm_password': confirmPassword,
      },
    );
    if (response.statusCode == 200) {
      await HelperFunctions.successBar(context, message: 'تم التعديل بنجاح');
       pushAndRemoveUntil(const MainPage());

      log('password changed');
    } else {
       HelperFunctions.errorBar(context, message: 'خطأ في التعديل ');

      log('error ');
    }
  }
}
