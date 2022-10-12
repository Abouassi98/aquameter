import 'package:aquameter/core/themes/themes.dart';
import 'package:flutter/material.dart';
import '../sizes.dart';

class CustomTextButton extends StatelessWidget {
  final String? title;
  final double? width, hieght, radius;
  final void Function() function;
  const CustomTextButton(
      {Key? key,
      required this.title,
      required this.function,
      this.width,
      this.radius,
      this.hieght})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hieght ?? Sizes.roundedButtonDefaultHeight(context),
      width: width ?? Sizes.roundedButtonDefaultWidth(context) * 0.5,
      child: TextButton(
        onPressed: function,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(4),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  radius ?? Sizes.roundedButtonDefaultRadius(context))),
          backgroundColor: const Color.fromRGBO(16, 107, 172, 1),
        ),
        child: Text(
          title!,
          style: MainTheme.buttonTextStyle,
        ),
      ),
    );
  }
}
