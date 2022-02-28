import 'package:aquameter/core/themes/screen_utility.dart';
import 'package:flutter/material.dart';

const kAppLogo = 'assets/images/Aquameter.png';
const kBackGroungLogo = 'assets/images/background.jfif';

ValueNotifier<Locale> locale = ValueNotifier(const Locale('en', 'US'));

///////////////////////////////////////////////////////////
/// theme
///////////////////////////////////////////////////////////

ThemeData appTheme = ThemeData(
  appBarTheme: appBarTheme,
  primaryColor: MainStyle.primaryColor,
  fontFamily: 'Tajawal',
  backgroundColor: Colors.grey[300],
  iconTheme: const IconThemeData(color: MainStyle.selectedIconColor),
);

AppBarTheme appBarTheme = const AppBarTheme(
    color: MainStyle.primaryColor,
    iconTheme: IconThemeData(color: MainStyle.selectedIconColor),
    elevation: 0.0,
    titleTextStyle: TextStyle(color: MainStyle.selectedIconColor));

///////////////////////////////////////////////////////////
/// Text Style
///////////////////////////////////////////////////////////

const String kMessage = 'message';
const String kExceptionMessage = 'There was an error please try again later';
const String kIsLoggedIn = 'logged in';
const String kToken = 'token';
const String kIsFirstTime = 'FirstTime';
const String storageKey = 'MyApplication_';
const String klanguage = 'language';
const String kcashedUserData = 'userData';
const Duration kDuration = Duration(milliseconds: 500);
