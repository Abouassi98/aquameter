import 'dart:developer';
import 'package:aquameter/features/Auth/data/user_model.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../constants.dart';

class HelperFunctions {
  static String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  static Future<T?> errorBar<T>(
    BuildContext context, {
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Flash(
            controller: controller,
            horizontalDismissDirection: HorizontalDismissDirection.horizontal,
            backgroundColor: Colors.black87,
            child: FlashBar(
              title: title == null
                  ? null
                  : Text('login', style: _titleStyle(context, Colors.white)),
              content:
                  Text(message, style: _contentStyle(context, Colors.white)),
              icon: Icon(Icons.warning, color: Colors.red[300]),
              indicatorColor: Colors.red[300],
            ),
          ),
        );
      },
    );
  }

  static Future<T?> successBar<T>(
    BuildContext context, {
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Flash(
            alignment: Alignment.bottomCenter,
            controller: controller,
            horizontalDismissDirection: HorizontalDismissDirection.horizontal,
            backgroundColor: Colors.black87,
            child: FlashBar(
              title: title == null
                  ? null
                  : Text('login', style: _titleStyle(context, Colors.white)),
              content:
                  Text(message, style: _contentStyle(context, Colors.white)),
              icon: Icon(Icons.check, color: Colors.green[300]),
              indicatorColor: Colors.green[300],
            ),
          ),
        );
      },
    );
  }

  static Future saveUser(data) async {
    await GetStorage.init().then((value) {
      GetStorage().write(kcashedUserData, data);
      GetStorage().write(kIsLoggedIn, true);

      log('IsLoggedIn >>> ${GetStorage().read(kIsLoggedIn)}');
      log(('cashedUserData >>> ${GetStorage().read(kcashedUserData)}'));
    });
  }

  static Future saveToken(String data) async {
    await GetStorage.init().then((value) {
      GetStorage().write(kToken, data);

      log(('kToken >>> ${GetStorage().read(kToken)}'));
    });
  }

  static Future saveFirstTime() async {
    await GetStorage.init().then((value) {
      GetStorage().write(kIsFirstTime, false);
      debugPrint(GetStorage().read(kIsFirstTime).toString());
    });
  }

  static Future saveLang(String? lang) async {
    await GetStorage.init().then((value) {
      GetStorage().write(klanguage, lang);
      debugPrint(GetStorage().read(kIsFirstTime));
    });
  }

  static Future saveApplicationInformation(String name, String value) async {
    await GetStorage.init().then((value) {
      GetStorage().write(storageKey + name, value);
      debugPrint(GetStorage().read(kIsFirstTime));
    });
  }

  static UserModel getUser() {
    return UserModel.fromJson(
      GetStorage().read(kcashedUserData),
    );
  }

  static updateUser(String x, dynamic value) async {
    var data = GetStorage().read(kcashedUserData);
    if (x == 'city' ||
        x == 'phone' ||
        x == 'id_number' ||
        x == 'profile_image' ||
        x == 'name' ||
        x == 'email') {
      if (data['data'] == null) {
        data['data'] = <String, dynamic>{
          'city': '',
          'phone': '',
          'profile_image': '',
          'id_number': ''
        };
      }
      data['data'][x] = value;
    } else {
      data['data'][x] = value;
    }
    debugPrint('$data');

    await GetStorage.init().then((value) {
      GetStorage().write(kcashedUserData, data);
      GetStorage().write(kIsLoggedIn, true);
    });
  }
}

TextStyle _titleStyle(BuildContext context, [Color? color]) {
  var theme = Theme.of(context);
  return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.headline6)!
      .copyWith(color: color);
}

TextStyle _contentStyle(BuildContext context, [Color? color]) {
  var theme = Theme.of(context);
  return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyText2)!
      .copyWith(color: color);
}
