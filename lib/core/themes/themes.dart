import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:flutter/material.dart';

class MainTheme {
  static TextStyle buttonTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Tajawal');
  static TextStyle hintTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: MainStyle.mainGray,
      fontFamily: 'Tajawal');

  static TextStyle headingTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subTextStyle =
      TextStyle(fontSize: 15, color: Colors.grey[200], fontFamily: 'Tajawal');
  static TextStyle subTextStyle2 = const TextStyle(
      fontSize: 10, color: MainStyle.mainGray, fontFamily: 'Tajawal');

  static TextStyle errorTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.red,
      fontFamily: 'Tajawal');
  static TextStyle menuTextStyle =
      const TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Tajawal');
}
