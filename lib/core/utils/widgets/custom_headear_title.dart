import 'package:aquameter/core/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomHeaderTitle extends StatelessWidget {
  final String title;
  const CustomHeaderTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: MainTheme.headingTextStyle,
        ),
      ),
    );
  }
}
