
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';




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
            behavior: FlashBehavior.fixed,
            position: FlashPosition.bottom,
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
            position: FlashPosition.bottom,
            behavior: FlashBehavior.fixed,
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
