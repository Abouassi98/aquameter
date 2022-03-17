import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomHeaderTitle extends StatelessWidget {
  final String title;
  final Color? color;
  const CustomHeaderTitle({Key? key, required this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * .03,
      width: SizeConfig.screenWidth * .75,
      decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Center(
          child: Text(title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
