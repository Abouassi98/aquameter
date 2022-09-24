import 'package:aquameter/core/utils/widgets/custom_header_title.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/splashScreen/presentation/screen/splah_screen.dart';
import 'package:flutter/material.dart';
import '../../routing/navigation_service.dart';
import 'connectivity_service.dart';


class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
                  NavigationService.pushReplacement(context,
                          page: const SplashScreen(), isNamed: false);
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
              const CustomHeaderTitle(
                title: '  من فضلك افحص اتصالك بالانترنت    ',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
                  title: 'اعد الاتصال',
                  function: () {
                    ConnectivityService.instance
                        .checkIfConnected()
                        .then((value) {
                      NavigationService.pushReplacement(context,
                          page: const SplashScreen(), isNamed: false);
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
