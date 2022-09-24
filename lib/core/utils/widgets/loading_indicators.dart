import 'package:aquameter/core/utils/widgets/platform_widgets/platform_circluar_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants.dart';
import '../sizes.dart';
import 'custom_text.dart';

class LoadingIndicators {
  LoadingIndicators._();

  static final instance = LoadingIndicators._();

  Widget defaultLoadingIndicator(
    BuildContext context, {
    String? message,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const PlatformCircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: Colors.transparent,

            valueColor: AlwaysStoppedAnimation<Color>(
         Colors.transparent,
            ),
            radius: 20,
          ),
          if (message != null)
            CustomText.h5(
              context,
              message,
              alignment: Alignment.center,
         
              color: Theme.of(context).textTheme.headline4!.color,
              margin: EdgeInsets.only(top: Sizes.vMarginHigh(context)),
            ),
        ],
      ),
    );
  }

  Widget smallLoadingAnimation(
    BuildContext context, {
    double? height,
    double? width,
  }) {
    return Center(
      child: Container(
        color: const Color.fromARGB(0, 83, 83, 83),
        child: Lottie.asset(
          kAppLoading,
          height: height ?? Sizes.loadingAnimationDefaultHeight(context),
          width: width ?? Sizes.loadingAnimationDefaultWidth(context),
        ),
      ),
    );
  }
}
