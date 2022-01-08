import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_dialog.dart';

import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';

import 'package:aquameter/features/calculator/presentation/screen/calculator.dart';

import 'package:aquameter/features/profileClient/data/meeting_all_model.dart';
import 'package:aquameter/features/profileClient/presentation/manager/meeting_all_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/pages/edit_client.dart';

import 'package:aquameter/features/profileClient/presentation/pages/view_client.dart';
import 'package:aquameter/features/profileClient/presentation/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


// ignore: must_be_immutable
class ProfileClientScreen extends HookConsumerWidget {
  final Client client;
  ProfileClientScreen({Key? key, required this.client}) : super(key: key);

  final List<Map<String, dynamic>> listofMeasuer = [
    {'name': 'معدل الملوحه', 'id': 1},
    {'name': 'معدلات الامونيا', 'id': 2},
  ];
  final GlobalKey<FormState> _averageWeight = GlobalKey<FormState>();
  String? selctedMeasuer;
  num totalWeight = 0.0, averageWeight = 0.0;
  int totalFishes = 0;

  final FutureProvider<MeetingAllModel> provider =
      FutureProvider<MeetingAllModel>((ref) async {
    return await ref
        .read(meetingAllNotifier.notifier)
        .meetingAll(); //; may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MeetingAllNotifier meetingAll = ref.read(meetingAllNotifier.notifier);

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: InkWell(
                onTap: () {
                  push(ViewClient(
                    client: client,
                  ));
                },
                child: Text(
                  client.name!,
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
                  push(EditClient(client: client));
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
          body: ref.watch(provider).when(
              loading: () => const Scaffold(body: AppLoader()),
              error: (e, o) {
                debugPrint(e.toString());
                debugPrint(o.toString());
                return const Text('error');
              },
              data: (e) => ListView(
                    primary: false,
                    shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.7,
                              child: Calendar(
                                events: meetingAll.selectedEvents,
                                eventDoneColor: Colors.red,
                                selectedColor: Colors.pink,
                                todayColor: Colors.blue,
                                eventColor: Colors.red,
                                isExpanded: true,
                                onDateSelected: (v) {
                                  if (meetingAll.selectedEvents[DateTime(
                                        int.parse(v.toString().substring(0, 4)),
                                        int.parse(v.toString().substring(6, 7)),
                                        int.parse(
                                          v.toString().substring(8, 10),
                                        ),
                                      )] !=
                                      null) {
                                  } else {
                                    push(Calculator());
                                  }
                                },
                                isExpandable: true,
                                locale: 'en_EN',
                                expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                                dayOfWeekStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                                        builder:
                                            (context, StateSetter setState) =>
                                                CustomDialog(
                                          title: 'احصد الآن',
                                          widget: [
                                            Form(
                                              key: _averageWeight,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CustomTextField(
                                                    hint:
                                                        'اجمالي وزن السمك بالكيلو',
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.3,
                                                    calculator: true,
                                                    onChange: (v) {
                                                      try {
                                                        totalWeight =
                                                            num.parse(v);
                                                      } on FormatException {
                                                        debugPrint(
                                                            'Format error!');
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
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.3,
                                                    onChange: (v) {
                                                      try {
                                                        totalFishes =
                                                            int.parse(v);
                                                      } on FormatException {
                                                        debugPrint(
                                                            'Format error!');
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
                                                              .toStringAsFixed(
                                                                  2) +
                                                          ' = متوسط الوزن',
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                CustomTextButton(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.1,
                                                    hieght: SizeConfig
                                                            .screenHeight *
                                                        0.05,
                                                    radius: 15,
                                                    title: ' = ',
                                                    function: () {
                                                      if (_averageWeight
                                                          .currentState!
                                                          .validate()) {
                                                        setState(() {
                                                          averageWeight =
                                                              totalWeight /
                                                                  totalFishes;
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
                                                hint:
                                                    'اجمالي وزن العلف بالكيلو',
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
                                                              .toStringAsFixed(
                                                                  2) +
                                                          ' = معدل النحويل',
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                CustomTextButton(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.1,
                                                    hieght: SizeConfig
                                                            .screenHeight *
                                                        0.05,
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
                                                  title: 'حفظ',
                                                  function: () {}),
                                            )
                                          ],
                                        ),
                                      ));
                            },
                          ),
                          CustomTextButton(
                              title: 'دورة جديده', function: () {}),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  )),
        ));
  }
}
