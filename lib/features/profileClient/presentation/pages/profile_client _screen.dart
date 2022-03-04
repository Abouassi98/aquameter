// ignore_for_file: must_be_immutable
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/presentation/manager/get_&_delete_clients_create_meeting_&_period_notifier.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:aquameter/features/calculator/presentation/screen/calculator.dart';
import 'package:aquameter/features/calculator/presentation/screen/show_calculator.dart';

import 'package:aquameter/features/profileClient/presentation/manager/update_and_endperiod_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/pages/edit_client.dart';
import 'package:aquameter/features/profileClient/presentation/pages/view_client.dart';
import 'package:aquameter/features/profileClient/presentation/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Home/Data/clients_model/client_model.dart';
import '../../../Home/presentation/pages/search_screen.dart';

import '../../data/period_results_model.dart';
import '../manager/profile_graph_notifier.dart';

class ProfileClientScreen extends ConsumerWidget {
  final Client client;
  final bool fromSearch;
  final CustomWarningDialog _dialog = CustomWarningDialog();

  ProfileClientScreen(
      {Key? key, required this.client, required this.fromSearch})
      : super(key: key);

  final List<Map<String, dynamic>> list = [
    {
      "name": 'الامونيا',
    },
    {
      "name": 'متوسط الوزن',
    },
    {
      "name": 'اعداد السمك',
    },
    {
      "name": 'معدل التحويل',
    },
    {
      "name": 'عدد السمك النافق',
    },
  ];

  final GlobalKey<FormState> _averageWeight = GlobalKey<FormState>();
  final GlobalKey<FormState> _conversionRate = GlobalKey<FormState>();
  String? selctedMeasuer;
  num totalWeight = 0.0, conversionRate = 0.0, totalFeed = 0, averageWeight = 0;
  int totalFishes = 0;

  final FutureProvider<PeriodResultsModel> provider =
      FutureProvider<PeriodResultsModel>((ref) async {
    return await ref
        .read(profileClientNotifer.notifier)
        .getPeriodResults(); //; may cause `provider` to rebuild
  });
  final StateProvider<List<num>> ammoniaProvider =
      StateProvider<List<num>>((ref) => []);
  final StateProvider<List<num>> averageWeightProvider =
      StateProvider<List<num>>((ref) => []);
  final StateProvider<List<num>> conversionRateProvider =
      StateProvider<List<num>>((ref) => []);
  final StateProvider<List<num>> totalFishesProvider =
      StateProvider<List<num>>((ref) => []);
  final StateProvider<List<num>> deadFishesProvider =
      StateProvider<List<num>>((ref) => []);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier clients =
        ref.read(getClientsNotifier.notifier);
    final ProfileClientNotifer profileClient =
        ref.read(profileClientNotifer.notifier);
    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    final UpdateAndDeletePeriodNotifier updateAndDeletePeriod =
        ref.read(updateAndDeletePeriodNotifier.notifier);
    final List<num> ammoniaList = ref.watch(ammoniaProvider);
    final List<num> averageWeightList = ref.watch(averageWeightProvider);
    final List<num> conversionRateList = ref.watch(conversionRateProvider);
    final List<num> totalFishesList = ref.watch(totalFishesProvider);
    final List<num> deadFishesList = ref.watch(deadFishesProvider);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                pop();
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
                        pushAndRemoveUntil(MainPage());
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
              profileClient.clientId = null;
              profileClient.isInit = false;
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
                        if (client.onlinePeriodsResultCount != 0)
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.53,
                            child: Calendar(
                              onMonthChanged: (v) {
                                if (DateTime.now().difference(v).inDays > 0) {}
                              },
                              onEventSelected: (v) {},
                              hideBottomBar: true,
                              events: profileClient.selectedEvents,
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
                                } else if (profileClient
                                        .selectedEvents[DateTime(
                                      int.parse(v.toString().substring(0, 4)),
                                      int.parse(v.toString().substring(6, 7)),
                                      int.parse(
                                        v.toString().substring(8, 10),
                                      ),
                                    )] !=
                                    null) {
                                  push(ShowCalculator(
                                    periodResults: e.data!.firstWhere((e) =>
                                        e.realDate!.substring(0, 10) ==
                                        v.toString().substring(0, 10)),
                                  ));
                                } else {
                                  totalFeed = 0;

                                  for (int i = 0;
                                      i <
                                          e.data!
                                              .where((element) =>
                                                  DateTime.parse(
                                                          element.realDate!)
                                                      .difference(v)
                                                      .inDays <=
                                                  0)
                                              .toList()
                                              .length;
                                      i++) {
                                    totalFeed += e.data!
                                        .where((element) =>
                                            DateTime.parse(element.realDate!)
                                                .difference(v)
                                                .inDays <=
                                            0)
                                        .toList()[i]
                                        .feed!;
                                  }

                                  push(Calculator(
                                    dateTime: v,
                                    client: client,
                                    totalFeed: totalFeed,
                                    meetingId: e.data![0].meetingId!,
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
                  if (client.onlinePeriodsResultCount != 0)
                    Center(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.4,
                        child: CustomBottomSheet(
                          name: 'الاحصائيات',
                          list: list,
                          staticList: true,
                          onChange: (v) {
                            if (v == 'الامونيا') {
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref.read(ammoniaProvider.state).state = [
                                ...profileClient
                                    .profileGraphModel!.data!.ammonia!
                              ];
                            } else if (v == 'متوسط الوزن') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref.read(averageWeightProvider.state).state = [
                                ...profileClient
                                    .profileGraphModel!.data!.avrageWeight!
                              ];
                            } else if (v == 'اعداد السمك') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref.read(totalFishesProvider.state).state = [
                                ...profileClient
                                    .profileGraphModel!.data!.totalNumber!
                              ];
                            } else if (v == 'معدل التحويل') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(conversionRateProvider.state).state = [
                                ...profileClient
                                    .profileGraphModel!.data!.conversionRate!
                              ];
                            } else if (v == 'عدد السمك النافق') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(deadFishesProvider.state).state = [
                                ...profileClient
                                    .profileGraphModel!.data!.numberOfDead!
                              ];
                            }
                          },
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (client.onlinePeriodsResultCount != 0 &&
                      ammoniaList.isNotEmpty)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Chart(
                        data: ammoniaList,
                      ),
                    ),
                  if (client.onlinePeriodsResultCount != 0 &&
                      averageWeightList.isNotEmpty)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Chart(
                        data: averageWeightList,
                      ),
                    ),
                  if (client.onlinePeriodsResultCount != 0 &&
                      deadFishesList.isNotEmpty)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Chart(
                        data: deadFishesList,
                      ),
                    ),
                  if (client.onlinePeriodsResultCount != 0 &&
                      conversionRateList.isNotEmpty)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Chart(
                        data: conversionRateList,
                      ),
                    ),
                  if (client.onlinePeriodsResultCount != 0 &&
                      totalFishesList.isNotEmpty)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Chart(
                        data: totalFishesList,
                      ),
                    ),
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
                                    builder: (context, StateSetter setState) =>
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
                                                      totalFeed = int.parse(v);
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
                                                    width:
                                                        SizeConfig.screenWidth *
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
                                                    if (conversionRate == 0.0) {
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
                                                          periodId: fromSearch ==
                                                                  true
                                                              ? client
                                                                  .onlinePeriodsResult![
                                                                      0]
                                                                  .id!
                                                              : e.data![0]
                                                                  .periodId!,
                                                          totalNumber:
                                                              totalFishes,
                                                          clientId: client.id!,
                                                          averageFooder:
                                                              totalFeed,
                                                          averageWeight:
                                                              averageWeight,
                                                          totalWeight:
                                                              totalWeight,
                                                          conversionRate:
                                                              conversionRate);

                                                      pushAndRemoveUntil(
                                                          MainPage());
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
                                            ? client.onlinePeriodsResult![0].id!
                                            : e.data![0].periodId!);
                                  }

                                  await clients.createPeriod(
                                    clientId: client.id!,
                                  );

                                  if (fromSearch == true) {
                                    pop();
                                  }
                                  pushReplacement(
                                    const SearchScreen(
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
    );
  }
}
