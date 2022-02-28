import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/features/Auth/data/user_model.dart';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'constants.dart';

class NetworkUtils {
  NetworkUtils();
  final baseUrl = 'https://aquameter-eg.com/public/api/';
  Dio dio = Dio();
  Response? response;
  static UserModel? loginData;
  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read(kToken)}',
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
      if (GetStorage().read(kIsLoggedIn) == true) {
        _headers.addAll({
          'Authorization': 'Bearer ${GetStorage().read(kToken)}',
        });
      }
      if (get == true) {
        response = await dio.get(baseUrl + url,
            options: Options(headers: _headers, receiveTimeout: 3000));
      } else {
        response = await dio.post(
          baseUrl + url,
          data: body,
          options: Options(headers: _headers, receiveTimeout: 3000),
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
      } else {
        dio.interceptors.add(
          RetryInterceptor(
            dio: dio,
            logPrint: print, // specify log function (optional)

            retries: 4, // retry count (optional)
            retryDelays: const [
              // set delays between retries (optional)
              Duration(seconds: 1), // wait 1 sec before first retry
              Duration(seconds: 3), // wait 2 sec before second retry
              Duration(seconds: 5), // wait 3 sec before third retry
              Duration(seconds: 10), // wait 3 sec before third retry
            ],
          ),
        );
        if (GetStorage().read(kIsLoggedIn) == true) {
          _headers.addAll({
            'Authorization': 'Bearer ${GetStorage().read(kToken)}',
          });
        }
        if (get == true) {
          response = await dio.get(baseUrl + url,
              options: Options(headers: _headers, receiveTimeout: 3000));
        } else {
          response = await dio.post(
            baseUrl + url,
            data: body,
            options: Options(headers: _headers, receiveTimeout: 3000),
            onSendProgress: (int sent, int total) {
              final progress = sent / total;
              debugPrint('progress: $progress ($sent/$total)');
            },
          );
        }
      }
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
        // await GetStorage.init().then((value) async {
        //   await GetStorage().remove(kcashedUserData);
        //   await GetStorage().remove(kIsLoggedIn);
        // });
        // loginData = null;

        Fluttertoast.showToast(
            msg: user.message!, toastLength: Toast.LENGTH_SHORT);
        // pushAndRemoveUntil(const SplashView());
        pop();
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
