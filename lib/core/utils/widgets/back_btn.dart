import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:flutter/material.dart';

class BackBtn extends StatelessWidget {
  final Color? color;
  final Function? onPress;

  const BackBtn({Key? key, this.color, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress as void Function()? ??
          () {
            FocusScope.of(context).requestFocus(FocusNode());
            pop();
          },
      icon: Icon(
        Icons.arrow_back_ios,
        size: 20,
        color: color ?? Colors.black,
      ),
    );
  }
}
