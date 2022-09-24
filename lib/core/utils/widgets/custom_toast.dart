import 'package:aquameter/core/themes/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../routing/navigation_service.dart';
import '../sizes.dart';



class CustomToast {
  CustomToast._();

  static final instance = CustomToast._();

  late FToast fToast = FToast();

  showDefaultToast(
    BuildContext context, {
    String title = '',
    String description = '',
    Color? backgroundColor,
    Gradient? backgroundGradient,
    double? borderRadius,
    BoxBorder? border,
    EdgeInsets? padding,
    EdgeInsets? margin,
    ToastGravity toastGravity = ToastGravity.TOP,
    Duration toastDuration = const Duration(seconds: 3),
    int fadeDuration = 350,
  }) {
    fToast.init(context);

    final toast = Container(
      width: double.infinity,
      margin: margin,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: Sizes.vPaddingSmall(context),
            horizontal: Sizes.hPaddingMedium(context),
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF303030),
        gradient: backgroundGradient,
        borderRadius: BorderRadius.circular(
          borderRadius ?? Sizes.toastRadius(context),
        ),
        border: border,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4, top: 4),
            child: Text(
              title,
              style:MainTheme.headingTextStyle,
              maxLines: 2,
            ),
          ),
          SizedBox(
            height: Sizes.vMarginTiny(context),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 4.0,
            ),
            child: Text(
              description,
              style:MainTheme.hintTextStyle,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );

    fToast.removeCustomToast();
    fToast.showToast(
      child: toast,
      gravity: toastGravity,
      toastDuration: toastDuration,
      fadeDuration: fadeDuration,
    );
  }

  Future showBackgroundToast({
    String msg = '',
    Color? backgroundColor,
    Toast toastLength = Toast.LENGTH_LONG,
    ToastGravity toastGravity = ToastGravity.TOP,
  }) async {
    await Fluttertoast.showToast(
      msg: msg,
      fontSize: 16,
      textColor: Colors.white,
      backgroundColor:
          backgroundColor ?? Theme.of(NavigationService.context).primaryColor,
      toastLength: toastLength,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
    );
  }
}
