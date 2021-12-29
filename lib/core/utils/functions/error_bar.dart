import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

Future<T?> errorBar<T>(
  BuildContext context, {
  String? title,
  required String message,
  required FlashPosition position,
  Duration duration = const Duration(seconds: 4),
}) {
  return showFlash<T>(
    context: context,
    duration: duration,
    builder: (context, controller) {
      return Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Flash(
            alignment: Alignment.bottomCenter,
            controller: controller,
            horizontalDismissDirection: HorizontalDismissDirection.horizontal,
            backgroundColor: Colors.black87,
            child: FlashBar(
              content:
                  Text(message, style: _contentStyle(context, Colors.white)),
              indicatorColor: Colors.red[300],
              icon: Icon(Icons.warning, color: Colors.red[300]),
            ),
          ),
        ),
      );
    },
  );
}

TextStyle _contentStyle(BuildContext context, [Color? color]) {
  var theme = Theme.of(context);
  return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyText2)!
      .copyWith(color: color);
}
