// import 'package:aquafish/src/screens/MainWidgets/register_text_field.dart';
import 'package:aquameter/core/themes/screen_utitlity.dart';

import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';

import 'package:aquameter/features/Home/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants.dart';

import '../size_config.dart';

// import 'defaultAppbar.dart';

class CustomAppBar extends HookConsumerWidget {
  final bool? search, back, drawer;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const CustomAppBar(
      {Key? key,
      this.search,
      this.onChanged,
      this.controller,
      this.back,
      this.drawer})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: MainStyle.primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (drawer == true)
                InkWell(
                  child: const Icon(Icons.menu),
                  onTap: () => Scaffold.of(context).openDrawer(),
                ),
              if (back == true)
                InkWell(
                  child: const Icon(Icons.arrow_back_ios),
                  onTap: () {
                    pop();
                  },
                ),
              search == true
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: CustomTextField(
                        controller: controller,
                        hint: 'بحث',
                        onChange: onChanged,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        push(SearchScreen());
                      }),
              SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                  width: 100,
                  child: Image.asset(
                    kAppLogo,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
          if (search != true || back != true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        HelperFunctions.getUser()
                            .clients!
                            .conversionRate!
                            .toString(),
                        style: const TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        'معدل التحويل',
                        style: TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        HelperFunctions.getUser()
                            .clients!
                            .fishWieght!
                            .toString(),
                        style: const TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        'الاسماك/طن',
                        style: TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        HelperFunctions.getUser()
                            .clients!
                            .totalFeed!
                            .toString(),
                        style: const TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        'الاعلاف/طن',
                        style: TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
