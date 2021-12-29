import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

Future<T?> successBar<T>(
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
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            content: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.check, color: Colors.green[300]),
            indicatorColor: Colors.green[300],
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
