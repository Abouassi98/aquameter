import 'package:aquameter/core/utils/widgets/custom_header_title.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';

import 'package:aquameter/features/splashScreen/presentation/splah_view.dart';

import 'package:flutter/material.dart';

import 'connectivity_service.dart';
import '../helper.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        pushAndRemoveUntil(const SplashView());
        return Future.value(true);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const CustomHeaderTitle(title: 'لا يوجد اتصال بالانترنت'),
              const SizedBox(
                height: 10,
              ),
              const CustomHeaderTitle(title: '  من فضلك افحص اتصالك بالانترنت    ',),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
                  title: 'اعد الاتصال',
                  function: () {
                    ConnectivityService.instance
                        .checkIfConnected()
                        .then((value) {
                      pushAndRemoveUntil(const SplashView());
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
