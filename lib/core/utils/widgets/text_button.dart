import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';

class CustomTextButton extends StatelessWidget {
  final String? title;
  final double? width, radius;
  final void Function() function;
  const CustomTextButton(
      {Key? key,
      required this.title,
      required this.function,
      this.width,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.08,
      width: width ?? SizeConfig.screenWidth * 0.3,
      child: TextButton(
        onPressed: function,
        child: Text(
          title!,
          style: MainTheme.buttonTextStyle,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(4),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10)),
          shadowColor: MainStyle.shadowColor,
          backgroundColor: const Color.fromRGBO(16, 107, 172, 1),
        ),
      ),
    );
  }
}
