import 'package:aquameter/core/themes/themes.dart';
import 'package:flutter/material.dart';
import '../sizes.dart';

class CustomText extends StatelessWidget {
  final String text;

  const CustomText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.roundedButtonMediumHeight(context),
      width: Sizes.roundedButtonMediumWidth(context) * 1.1,
      child: MaterialButton(
        onPressed: () {},
        color: Colors.blue[400],
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                Sizes.roundedButtonDefaultRadius(context))),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: MainTheme.buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
