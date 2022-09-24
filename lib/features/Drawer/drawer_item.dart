import 'package:aquameter/core/themes/themes.dart';
import 'package:flutter/material.dart';

class DrwaerItem extends StatelessWidget {
  final String text;
  final Widget widget;
  final void Function() onTap;
  const DrwaerItem({
    Key? key,
    required this.text,
    required this.onTap,
    required this.widget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
            top: 10,
            bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget,
            const SizedBox(
              width: 23,
            ),
            Text(
              text,
              style: MainTheme.subTextStyle.copyWith(color: Colors.black26),
            )
          ],
        ),
      ),
    );
  }
}
