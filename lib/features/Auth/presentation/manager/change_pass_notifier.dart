import 'dart:developer';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePassNotifier extends StateNotifier<void> {
  ChangePassNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();

  changePassword({
    String? password,
    String? confirmPassword,
  }) async {
    Response response = await _utils.requstData(
      url: 'editProfile',
      body: {
        'password': password,
        'confirm_password': confirmPassword,
      },
    );
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(

          msg: 'تم التعديل بنجاح', toastLength: Toast.LENGTH_SHORT);
      pushAndRemoveUntil(const MainPage());

      log('password changed');
    } else {
      Fluttertoast.showToast(
          msg: 'خطأ في التعديل', toastLength: Toast.LENGTH_SHORT);

      log('error ');
    }
  }
}
