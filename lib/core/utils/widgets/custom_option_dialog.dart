import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/localization/manager/app_localization.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';

class CustomOptionDialog extends StatelessWidget {
  final String title;
  final void Function() function;
  const CustomOptionDialog(
      {Key? key, required this.title, required this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: MainTheme.headingTextStyle.copyWith(color: Colors.black),
      ),
      actions: [
        SizedBox(
          width: SizeConfig.screenWidth * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextButton(
                title: localization.text('no'),
                function: () {
                  pop();
                },
              ),
              CustomTextButton(
                title: localization.text('yes'),
                function: function,
              )
            ],
          ),
        )
      ],
    );
  }
}
