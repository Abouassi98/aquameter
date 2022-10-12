import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/services/localization_service.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:flutter/material.dart';
import '../routing/navigation_service.dart';
import '../sizes.dart';

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
          width: Sizes.fullScreenWidth(context) * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextButton(
                width: Sizes.roundedButtonDefaultWidth(context) * 0.4,
                title: tr(context).cancel,
                function: () {
                  NavigationService.goBack(context);
                },
              ),
              CustomTextButton(
                width: Sizes.roundedButtonDefaultWidth(context) * 0.4,
                title: tr(context).confirm,
                function: function,
              )
            ],
          ),
        )
      ],
    );
  }
}
