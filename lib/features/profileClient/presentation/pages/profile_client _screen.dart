// ignore_for_file: must_be_immutable
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/presentation/manager/get_&_delete_clients_create_meeting_&_period_notifier.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:aquameter/features/calculator/presentation/screen/calculator.dart';
import 'package:aquameter/features/calculator/presentation/screen/show_calculator.dart';
import 'package:aquameter/features/profileClient/presentation/manager/meeting_all_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/manager/update_and_endperiod_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/pages/edit_client.dart';
import 'package:aquameter/features/profileClient/presentation/pages/view_client.dart';
import 'package:aquameter/features/profileClient/presentation/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../Home/presentation/pages/search_screen.dart';
import '../../data/meeting_all_model..dart';

class ProfileClientScreen extends HookConsumerWidget {
  final Client client;
  final bool fromSearch;
  final CustomWarningDialog _dialog = CustomWarningDialog();

  ProfileClientScreen(
      {Key? key, required this.client, required this.fromSearch})
      : super(key: key);

  final List<Map<String, dynamic>> listofMeasuer = [
    {'name': 'معدل الملوحه', 'id': 1},
    {'name': 'معدلات الامونيا', 'id': 2},
  ];
  final GlobalKey<FormState> _averageWeight = GlobalKey<FormState>();
  final GlobalKey<FormState> _conversionRate = GlobalKey<FormState>();
  String? selctedMeasuer, allPreviousFishes = '';
  num totalWeight = 0.0, conversionRate = 0.0, totalFeed = 0, averageWeight = 0;
  int totalFishes = 0;

  final FutureProvider<MeetingAllModel> provider =
      FutureProvider<MeetingAllModel>((ref) async {
    return await ref
        .read(meetingAllNotifier.notifier)
        .meetingAll(); //; may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier clients =
        ref.read(getClientsNotifier.notifier);
    final MeetingAllNotifier meetingAll = ref.read(meetingAllNotifier.notifier);
    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    final UpdateAndDeletePeriodNotifier updateAndDeletePeriod =
        ref.read(updateAndDeletePeriodNotifier.notifier);
    return WillPopScope(
      onWillPop: () async {
        pushAndRemoveUntil(const MainPage());
        return true;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  pushAndRemoveUntil(const MainPage());
                },
                icon: const Icon(Icons.arrow_back)),
            title: InkWell(
              onTap: () async {
                await areaAndCites.getCities(cityId: client.governorate);
                push(ViewClient(
                  client: client,
                  areaAndCites: areaAndCites,
                ));
              },
              child: Text(
                client.name!,
                style: MainTheme.headingTextStyle.copyWith(color: Colors.white),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await areaAndCites.getCities(cityId: client.governorate);
                  push(EditClient(client: client));
                },
              ),
              IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await _dialog.showOptionDialog(
                        context: context,
                        msg: 'هل ترغب بحذف العميل ؟',
                        okFun: () async {
                          await clients.deleteClient(clientId: client.id!);
                          pushAndRemoveUntil(const MainPage());
                        },
                        okMsg: 'نعم',
                        cancelMsg: 'لا',
                        cancelFun: () {
                          return;
                        });
                  }),
            ],
          ),
          body: ref.watch(provider).when(
              loading: () => const AppLoader(),
              error: (e, o) {
                debugPrint(e.toString());
                debugPrint(o.toString());
                return const Text('error');
              },
              data: (e) {
                meetingAll.id = null;
                meetingAll.isInit = false;
                return ListView(
                  primary: false,
                  shrinkWrap: true,
                  //scrollDirection: Axis.horizontal,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          if (client.onlinePeriodsResultCount != 0&&e.data!.isNotEmpty)
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.6,
                              child: Calendar(
                                onMonthChanged: (v) {
                                  if (DateTime.now().difference(v).inDays >
                                      0) {}
                                },
                                onEventSelected: (v) {},
                                hideBottomBar: true,
                                events: meetingAll.selectedEvents,
                                startOnMonday: true,
                                weekDays: const [
                                  'الاثنين',
                                  'الثلاثاء',
                                  'الاربعاء',
                                  'الخميس',
                                  'الجمعه',
                                  'السبت',
                                  'الحد'
                                ],
                                eventDoneColor: Colors.red,
                                selectedColor: Colors.pink,
                                todayColor: Colors.blue,
                                eventColor: Colors.red,
                                hideTodayIcon: true,
                                isExpanded: true,
                                onDateSelected: (v) {
                                  if (DateTime.now().difference(v).inDays < 0) {
                                    HelperFunctions.errorBar(context,
                                        message: 'لا يمكن زياره تاريخ مستقبلي');
                                  } else if (meetingAll.selectedEvents[DateTime(
                                        int.parse(v.toString().substring(0, 4)),
                                        int.parse(v.toString().substring(6, 7)),
                                        int.parse(
                                          v.toString().substring(8, 10),
                                        ),
                                      )] !=
                                      null) {
                                    push(ShowCalculator(
                                      meetingResult: e.data![0].meetingResult!
                                          .firstWhere((e) =>
                                              e.realDate!.substring(0, 10) ==
                                              v.toString().substring(0, 10)),
                                    ));
                                  } else {
                                    totalFeed = 0;
                                    for (int i = 0;
                                        i <
                                            e.data![0].meetingResult!
                                                .where((element) =>
                                                    DateTime.parse(
                                                            element.realDate!)
                                                        .difference(v)
                                                        .inDays <=
                                                    0)
                                                .toList()
                                                .length;
                                        i++) {
                                      totalFeed += e.data![0].meetingResult!
                                          .where((element) =>
                                              DateTime.parse(element.realDate!)
                                                  .difference(v)
                                                  .inDays <=
                                              0)
                                          .toList()[0]
                                          .feed!;
                                    }
                                    allPreviousFishes =
                                        e.data![0].client!.fish![0].number!;

                                    push(Calculator(
                                      dateTime: v,
                                      allPreviousFishes: allPreviousFishes!,
                                      client: client,
                                      totalFeed: totalFeed,
                                      meetingId: e.data![0].id!,
                                    ));
                                  }
                                },
                                dayOfWeekStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    if (client.onlinePeriodsResultCount != 0)
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
                    if (client.onlinePeriodsResultCount != 0)
                      const Directionality(
                          textDirection: TextDirection.ltr, child: Chart()),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (client.onlinePeriodsResultCount != 0)
                          CustomTextButton(
                            title: 'احصد الآن',
                            function: () {
                              conversionRate = 0.0;
                              averageWeight = 0.0;
                              showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                      builder: (context,
                                              StateSetter setState) =>
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
                                                      width: SizeConfig
                                                              .screenWidth *
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
                                                      type:
                                                          TextInputType.number,
                                                      paste: false,
                                                    ),
                                                    CustomTextField(
                                                      hint: 'اعداد السمك',
                                                      width: SizeConfig
                                                              .screenWidth *
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
                                                      type:
                                                          TextInputType.number,
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
                                                      width: SizeConfig
                                                              .screenWidth *
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
                                                                (totalWeight /
                                                                        totalFishes)
                                                                    .round();
                                                          });
                                                        }
                                                      }),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Form(
                                                key: _conversionRate,
                                                child: Center(
                                                  child: CustomTextField(
                                                    hint:
                                                        'اجمالي وزن العلف بالكيلو',
                                                    calculator: true,
                                                    onChange: (v) {
                                                      try {
                                                        totalFeed =
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
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomBtn(
                                                    text: conversionRate == 0.0
                                                        ? '0.0 = معدل النحويل'
                                                        : conversionRate
                                                                .toStringAsFixed(
                                                                    2) +
                                                            ' = معدل النحويل',
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  CustomTextButton(
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.1,
                                                      hieght: SizeConfig
                                                              .screenHeight *
                                                          0.05,
                                                      radius: 15,
                                                      title: ' = ',
                                                      function: () {
                                                        if (_conversionRate
                                                            .currentState!
                                                            .validate()) {
                                                          setState(() {
                                                            conversionRate =
                                                                totalFeed /
                                                                    totalWeight;
                                                          });
                                                        }
                                                      }),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: CustomTextButton(
                                                    title: 'حفظ',
                                                    function: () async {
                                                      if (conversionRate ==
                                                          0.0) {
                                                        HelperFunctions.errorBar(
                                                            context,
                                                            message:
                                                                'يجب عليك اظهار ناتج معدل التحويل');
                                                      } else if (averageWeight ==
                                                          0.0) {
                                                        HelperFunctions.errorBar(
                                                            context,
                                                            message:
                                                                'يجب عليك اظهار ناتج متوسط الوزن');
                                                      } else if (_averageWeight
                                                              .currentState!
                                                              .validate() &&
                                                          _conversionRate
                                                              .currentState!
                                                              .validate()) {
                                                        await updateAndDeletePeriod.endPeriod(
                                                            periodId:
                                                                fromSearch ==
                                                                        true
                                                                    ? client
                                                                        .onlinePeriodsResult![
                                                                            0]
                                                                        .id!
                                                                    : e
                                                                        .data![
                                                                            0]
                                                                        .periodId!,
                                                            totalNumber:
                                                                totalFishes,
                                                            clientId:
                                                                client.id!,
                                                            averageFooder:
                                                                totalFeed,
                                                            averageWeight:
                                                                averageWeight,
                                                            totalWeight:
                                                                totalWeight,
                                                            conversionRate:
                                                                conversionRate);

                                                        pushAndRemoveUntil(
                                                            const MainPage());
                                                      }
                                                    }),
                                              )
                                            ],
                                          )));
                            },
                          ),
                        CustomTextButton(
                            title: 'دورة جديده',
                            function: () async {
                              await _dialog.showOptionDialog(
                                  context: context,
                                  msg: (client.onlinePeriodsResultCount == 0)
                                      ? 'هل ترغب بانشاء دوره جديده'
                                      : 'هل ترغب بانهاء الدوره وانشاء دوره جديده ؟',
                                  okFun: () async {
                                    if (client.onlinePeriodsResultCount != 0) {
                                      await updateAndDeletePeriod.endPeriod(
                                          clientId: client.id!,
                                          periodId: fromSearch == true
                                              ? client
                                                  .onlinePeriodsResult![0].id!
                                              : e.data![0].periodId!);
                                    }

                                    await clients.createPeriod(
                                      clientId: client.id!,
                                    );

                                    if (fromSearch == true) {
                                      pop();
                                    }
                                    pushReplacement(
                                      SearchScreen(
                                        viewProfile: true,
                                      ),
                                    );
                                  },
                                  okMsg: 'نعم',
                                  cancelMsg: 'لا',
                                  cancelFun: () {
                                    return;
                                  });
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
