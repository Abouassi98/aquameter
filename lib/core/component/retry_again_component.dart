import 'package:aquameter/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/services/localization_service.dart';
import '../utils/sizes.dart';
import '../utils/widgets/text_button.dart';
import '../viewmodels/location_service_provider/location_service_provider.dart';

class RetryAgainComponent extends ConsumerWidget {
  final String description;

  const RetryAgainComponent({
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.screenHPaddingMedium(context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            description,
            style: MainTheme.headingTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Sizes.vMarginMedium(context),
          ),
          CustomTextButton(
            title: tr(context).retry,
            function:
                ref.watch(locationServiceProvider.notifier).getCurrentLocation,
          ),
        ],
      ),
    );
  }
}
