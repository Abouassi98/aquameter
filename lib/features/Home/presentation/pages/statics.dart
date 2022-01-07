import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';

import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/presentation/manager/get_clients_notifier.dart';

import 'package:aquameter/features/Home/presentation/widgets/circle_chart.dart';
import 'package:aquameter/features/Home/presentation/widgets/list_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Statics extends HookConsumerWidget {
   Statics({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> list2 = [
    {
      "name": 'المحافظات',
    },
    {
      "name": 'انواع السمك',
    },
    {
      "name": 'انواع العلف',
    },
  ];

   @override
  Widget build(BuildContext context, WidgetRef ref) {

     return ListView(
      children: [
        SizedBox(
          width: context.width * .6,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * .01,
              ),
              Center(
                  child: SizedBox(
                      width: context.width * .5,
                      child:
                          CustomBottomSheet(name: 'الاحصائيات', list: list2))),
              SizedBox(
                height: SizeConfig.screenHeight * .01,
              ),
              const CircleChart(),
            ],
          ),
        ),
        Divider(
          color: Colors.grey[300],
          thickness: 2,
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime(2021),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2030))
                    .then((pickedDate) {
                  if (pickedDate == null) {
                    //if user tap cancel then this function will stop
                    return;
                  }
                });
              },
              child: const Text(
                'من',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
            const Text(':'),
            TextButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030))
                    .then((pickedDate) {
                  if (pickedDate == null) {
                    //if user tap cancel then this function will stop
                    return;
                  }
                });
              },
              child: const Text(
                'الي',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.height * .01,
        ),
        Center(
          child: SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child:  ListSelectorWidget()),
        ),
        SizedBox(
          height: context.height * .03,
        ),
        Center(
          child: SizedBox(
              width: SizeConfig.screenWidth * 0.3,
              child: CustomTextButton(title: "تحميل التقرير", function: () {})),
        ),
        SizedBox(
          height: context.height * .06,
        ),
      ],
    );
  }
}
