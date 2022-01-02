import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;

  const CustomBtn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.08,
      width: SizeConfig.screenWidth * 0.4,
      child: MaterialButton(
        onPressed: () {},
        color: Colors.blue[400],
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
