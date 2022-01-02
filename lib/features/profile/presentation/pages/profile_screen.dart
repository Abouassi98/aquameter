import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/calculator/presentation/screen/calculator.dart';
import 'package:aquameter/features/profile/presentation/widgets/chart.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import 'add_client.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> listofMeasuer = [
    {'name': 'معدل الملوحه', 'id': 1},
    {'name': 'معدلات الامونيا', 'id': 2},
  ];
  String? selctedMeasuer;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: InkWell(
                onTap: () {
                  push(AddClient());
                },
                child: Text(
                  "الحاج محمود مصطفى محمد",
                  style:
                      MainTheme.headingTextStyle.copyWith(color: Colors.white),
                )),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  push(AddClient());
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: ListView(
            primary: false,
            shrinkWrap: true,
            //scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                height: 20,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: TableCalendar(
                  availableGestures: AvailableGestures.horizontalSwipe,
                  firstDay: DateTime(2021),
                  focusedDay: DateTime.now(),
                  lastDay: DateTime(2030),
                  onDaySelected: (e, d) {
                    push( Calculator());
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: SizeConfig.screenWidth * 0.4,
                  child: CustomBottomSheet(
                    name: 'معدلات الامونيا',
                    list: listofMeasuer,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: DateTimeComboLinePointChart.withSampleData()),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextButton(
                    title: 'احصد الآن',
                    function: () {},
                  ),
                  CustomTextButton(title: 'دورة جديده', function: () {}),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }
}
