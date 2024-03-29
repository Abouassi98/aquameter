import 'package:aquameter/core/themes/screen_utility.dart';
import 'package:flutter/material.dart';

const kAppLogo = 'assets/images/Aquameter.png';
const kAppLoading = 'assets/json/loading_animation.json';
const kBackGroungLogo = 'assets/images/background.jfif';
final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);


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
const String kLocale = "locale";
const String kIsLoggedIn = 'logged in';
const String kToken = 'token';
const String klanguage = 'language';
const String kcashedUserData = 'userData';
const Duration kDuration = Duration(milliseconds: 500);
