import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:flutter/material.dart';
import '../utils/services/localization_service.dart';
import '../utils/sizes.dart';
import '../utils/widgets/custom_text.dart';
import '../utils/widgets/loading_indicators.dart';

class DataErrorComponent extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;

  const DataErrorComponent({
    required this.title,
    required this.description,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadingIndicators.instance.smallLoadingAnimation(context),
        SizedBox(
          height: Sizes.vMarginHigh(context),
        ),
        CustomText.h2(
          context,
          title,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: Sizes.vMarginSmallest(context),
        ),
        CustomText.h5(
          context,
          description,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: Sizes.vMarginHigh(context),
        ),
        CustomTextButton(
          title: tr(context).retry,
          function: onPressed,
        ),
      ],
    );
  }
}
