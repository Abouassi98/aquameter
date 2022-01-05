import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aquameter/features/Auth/data/user_model.dart';
import 'package:aquameter/features/splashScreen/presentation/splah_view.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get_storage/get_storage.dart';

import 'constants.dart';
import 'functions/helper.dart';

class NetworkUtils {
  NetworkUtils();
  final baseUrl = 'https://aquameter-eg.com/public/api/';
  Dio dio = Dio();
  Response? response;
  static UserModel? loginData;
  final Map<String, String> _headers = {
    if (GetStorage().read(kIsLoggedIn) == true)
      'Authorization': 'Bearer ${GetStorage().read(kToken)}'
  };

  Future<Response> requstData({
    required String url,
    dynamic body,
    bool? get,
  }) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      if (get == true) {
        response =
            await dio.get(baseUrl + url, options: Options(headers: _headers));
      } else {
        response = await dio.post(
          baseUrl + url,
          data: body,
          options: Options(headers: _headers),
          onSendProgress: (int sent, int total) {
            final progress = sent / total;
            debugPrint('progress: $progress ($sent/$total)');
          },
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        debugPrint('response: ' + e.response.toString());
      } else {}
    }
    return handleResponse(response!);
  }

  Future<Response> handleResponse(
    Response response,
  ) async {
    String message = '';
    if (response.data.runtimeType == String) {
      if (response.data != null) {
        String body = response.data;
        var jsonObject = jsonDecode(body);
        message = jsonObject['message'];
        Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
      }
      return Response(
          statusCode: 102,
          data: {
            'mainCode': 0,
            'code': 102,
            'data': null,
            'error': [
              {'key': 'internet', 'value': 'هناك خطا يرجي اعادة المحاولة'}
            ]
          },
          requestOptions: RequestOptions(path: ''));
    } else {
      final int statusCode = response.statusCode!;
      log('response: ' + response.toString());
      log('statusCode: ' + statusCode.toString());
      if (statusCode == 200 && statusCode < 300) {
        return response;
      } else if (statusCode == 400) {
        Fluttertoast.showToast(
            msg: loginData!.message!, toastLength: Toast.LENGTH_SHORT);
        return response;
      } else if (statusCode == 401) {
        UserModel user = UserModel.fromJson(response.data);
        await GetStorage.init().then((value) async {
          await GetStorage().remove(kcashedUserData);
          await GetStorage().remove(kIsLoggedIn);
        });
        loginData = null;

        Fluttertoast.showToast(
            msg: user.message!, toastLength: Toast.LENGTH_SHORT);
        pushAndRemoveUntil(const SplashView());
        return response;
      } else if (statusCode <= 500) {
        Fluttertoast.showToast(
            msg: 'يرجي التحقق من الاتصال بالانترنت',
            toastLength: Toast.LENGTH_SHORT);
        return Response(
            statusCode: 500,
            data: {
              'mainCode': 0,
              'code': 500,
              'data': null,
              'error': [
                {'key': 'internet', 'value': 'يرجي التحقق من الاتصال بالانترنت'}
              ]
            },
            requestOptions: RequestOptions(path: ''));
      } else {
        return response;
      }
    }
  }
}
