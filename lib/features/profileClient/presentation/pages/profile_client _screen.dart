import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_dialog.dart';

import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/calculator/presentation/screen/calculator.dart';
import 'package:aquameter/features/profileClient/presentation/widgets/chart.dart';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:table_calendar/table_calendar.dart';

import 'add_client.dart';

// ignore: must_be_immutable
class ProfileClientScreen extends HookConsumerWidget {
  ProfileClientScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> listofMeasuer = [
    {'name': 'معدل الملوحه', 'id': 1},
    {'name': 'معدلات الامونيا', 'id': 2},
  ];
  final GlobalKey<FormState> _averageWeight = GlobalKey<FormState>();
  String? selctedMeasuer;
  num totalWeight = 0.0, averageWeight = 0.0;
  int totalFishes = 0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  onFormatChanged: (c) {},
                  lastDay: DateTime(2030),
                  onDaySelected: (e, d) {
                    push(Calculator());
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
                    function: () {
                      showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                                builder: (context, StateSetter setState) =>
                                    CustomDialog(
                                  title: 'احصد الآن',
                                  widget: [
                                    Form(
                                      key: _averageWeight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomTextField(
                                            hint: 'اجمالي وزن السمك بالكيلو',
                                            width: SizeConfig.screenWidth * 0.3,
                                            calculator: true,
                                            onChange: (v) {
                                              try {
                                                totalWeight = num.parse(v);
                                              } on FormatException {
                                                debugPrint('Format error!');
                                              }
                                            },
                                            validator: (v) {
                                              if (v!.isEmpty) {
                                                return 'لا يجب ترك الحقل فارغ';
                                              }
                                              return null;
                                            },
                                            numbersOnly: true,
                                            type: TextInputType.number,
                                            paste: false,
                                          ),
                                          CustomTextField(
                                            hint: 'اعداد السمك',
                                            width: SizeConfig.screenWidth * 0.3,
                                            onChange: (v) {
                                              try {
                                                totalFishes = int.parse(v);
                                              } on FormatException {
                                                debugPrint('Format error!');
                                              }
                                            },
                                            validator: (v) {
                                              if (v!.isEmpty) {
                                                return 'لا يجب ترك الحقل فارغ';
                                              }
                                              return null;
                                            },
                                            numbersOnly: true,
                                            type: TextInputType.number,
                                            paste: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomBtn(
                                          text: averageWeight == 0.0
                                              ? '0.0 = متوسط الوزن'
                                              : averageWeight
                                                      .toStringAsFixed(2) +
                                                  ' = متوسط الوزن',
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        CustomTextButton(
                                            width: SizeConfig.screenWidth * 0.1,
                                            hieght:
                                                SizeConfig.screenHeight * 0.05,
                                            radius: 15,
                                            title: ' = ',
                                            function: () {
                                              if (_averageWeight.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  averageWeight =
                                                      totalWeight / totalFishes;
                                                });
                                              }
                                            }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: CustomTextField(
                                        hint: 'اجمالي وزن العلف بالكيلو',
                                        calculator: true,
                                        onChange: (v) {
                                          try {
                                            totalWeight = num.parse(v);
                                          } on FormatException {
                                            debugPrint('Format error!');
                                          }
                                        },
                                        validator: (v) {
                                          if (v!.isEmpty) {
                                            return 'لا يجب ترك الحقل فارغ';
                                          }
                                          return null;
                                        },
                                        numbersOnly: true,
                                        type: TextInputType.number,
                                        paste: false,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomBtn(
                                          text: averageWeight == 0.0
                                              ? '0.0 = معدل النحويل'
                                              : averageWeight
                                                      .toStringAsFixed(2) +
                                                  ' = معدل النحويل',
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        CustomTextButton(
                                            width: SizeConfig.screenWidth * 0.1,
                                            hieght:
                                                SizeConfig.screenHeight * 0.05,
                                            radius: 15,
                                            title: ' = ',
                                            function: () {}),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: CustomTextButton(
                                          title: 'حفظ', function: () {}),
                                    )
                                  ],
                                ),
                              ));
                    },
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
