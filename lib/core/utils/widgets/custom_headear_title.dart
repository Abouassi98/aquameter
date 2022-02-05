import 'package:aquameter/core/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomHeaderTitle extends StatelessWidget {
  final String title;
  final Color?   color;
  const CustomHeaderTitle({Key? key, required this.title,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          color: color??Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style:   MainTheme.headingTextStyle,
        ),
      ),
    );
  }
}
