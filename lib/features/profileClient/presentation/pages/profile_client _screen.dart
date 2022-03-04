// ignore_for_file: must_be_immutable
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/size_config.dart';
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
import '../../data/profile_graph_model.dart';
import '../manager/profile_graph_notifier.dart';

class ProfileClientScreen extends ConsumerWidget {
  final Client client;

  final CustomWarningDialog _dialog = CustomWarningDialog();

  ProfileClientScreen({
    Key? key,
    required this.client,
  }) : super(key: key);

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
    {
      "name": 'درجات الحراره',
    },
    {
      "name": 'ph معدلات',
    },
    {
      "name": 'الملوحه',
    },
    {
      "name": 'الاكسجين',
    },
    {
      "name": 'الامونيا السامه',
    },
  ];
  final FutureProviderFamily<ProfileGraphModel, int> provider =
      FutureProvider.family<ProfileGraphModel, int>((ref, id) async {
    return await ref
        .watch(profileClientNotifer.notifier)
        .getProfileGraph(id); //; may cause `provider` to rebuild
  });
  final GlobalKey<FormState> _averageWeight = GlobalKey<FormState>();
  final GlobalKey<FormState> _conversionRate = GlobalKey<FormState>();
  String? selctedMeasuer;
  num totalWeight = 0.0, conversionRate = 0.0, totalFeed = 0, averageWeight = 0;
  int totalFishes = 0;

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
  final StateProvider<List<num>> toxicAmmoniaProvider =
      StateProvider<List<num>>((ref) => []);
  final StateProvider<List<num>> temperatureProvider =
      StateProvider<List<num>>((ref) => []);
  final StateProvider<List<num>> phProvider =
      StateProvider<List<num>>((ref) => []);
  final StateProvider<List<num>> salinityProvider =
      StateProvider<List<num>>((ref) => []);
  final StateProvider<List<num>> oxygenProvider =
      StateProvider<List<num>>((ref) => []);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier clients =
        ref.read(getClientsNotifier.notifier);

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
    final List<num> toxicAmmoniaList = ref.watch(toxicAmmoniaProvider);
    final List<num> temperatureList = ref.watch(temperatureProvider);
    final List<num> phList = ref.watch(phProvider);
    final List<num> salinityList = ref.watch(salinityProvider);
    final List<num> oxygenList = ref.watch(oxygenProvider);

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
                  color: Colors.red,
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
        body: ListView(
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
                        events: clients.selectedEvents,
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
                          } else if (clients.selectedEvents[DateTime(
                                int.parse(v.toString().substring(0, 4)),
                                int.parse(v.toString().substring(6, 7)),
                                int.parse(
                                  v.toString().substring(8, 10),
                                ),
                              )] !=
                              null) {
                            push(ShowCalculator(
                              periodResults: client
                                  .onlinePeriodsResult![0].meetingResults!
                                  .firstWhere((e) =>
                                      e.realDate!.substring(0, 10) ==
                                      v.toString().substring(0, 10)),
                            ));
                          } else {
                            totalFeed = 0;
                            if (client
                                .onlinePeriodsResult![0].meetings!.isEmpty) {
                              HelperFunctions.errorBar(context,
                                  message:
                                      'يجب عليك ان تضع العميل ميعاد في الخطه اولا');
                            } else {
                              for (int i = 0;
                                  i <
                                      client.onlinePeriodsResult![0]
                                          .meetingResults!
                                          .where((element) =>
                                              DateTime.parse(element.realDate!)
                                                  .difference(v)
                                                  .inDays <=
                                              0)
                                          .toList()
                                          .length;
                                  i++) {
                                totalFeed += client
                                    .onlinePeriodsResult![0].meetingResults!
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
                                meetingId: client
                                    .onlinePeriodsResult![0].meetings![0].id!,
                              ));
                            }
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
              ref.watch(provider(client.id!)).when(
                    loading: () => const Center(child:  CircularProgressIndicator()),
                    error: (e, o) {
                      debugPrint(e.toString());
                      debugPrint(o.toString());
                      return const Text('error');
                    },
                    data: (e) => Center(
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
                              ref
                                  .read(toxicAmmoniaProvider.state)
                                  .state
                                  .clear();
                              ref.read(temperatureProvider.state).state.clear();
                              ref.read(phProvider.state).state.clear();
                              ref.read(salinityProvider.state).state.clear();
                              ref.read(oxygenProvider.state).state.clear();
                              ref.read(ammoniaProvider.state).state = [
                                ...e.data!.ammonia!
                              ];
                            } else if (v == 'متوسط الوزن') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(toxicAmmoniaProvider.state)
                                  .state
                                  .clear();
                              ref.read(temperatureProvider.state).state.clear();
                              ref.read(phProvider.state).state.clear();
                              ref.read(salinityProvider.state).state.clear();
                              ref.read(oxygenProvider.state).state.clear();
                              ref.read(averageWeightProvider.state).state = [
                                ...e.data!.avrageWeight!
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
                              ref
                                  .read(toxicAmmoniaProvider.state)
                                  .state
                                  .clear();
                              ref.read(temperatureProvider.state).state.clear();
                              ref.read(phProvider.state).state.clear();
                              ref.read(salinityProvider.state).state.clear();
                              ref.read(oxygenProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state = [
                                ...e.data!.totalNumber!
                              ];
                            } else if (v == 'معدل التحويل') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref
                                  .read(toxicAmmoniaProvider.state)
                                  .state
                                  .clear();
                              ref.read(temperatureProvider.state).state.clear();
                              ref.read(phProvider.state).state.clear();
                              ref.read(salinityProvider.state).state.clear();
                              ref.read(oxygenProvider.state).state.clear();
                              ref.read(conversionRateProvider.state).state = [
                                ...e.data!.conversionRate!
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
                              ref
                                  .read(toxicAmmoniaProvider.state)
                                  .state
                                  .clear();
                              ref.read(temperatureProvider.state).state.clear();
                              ref.read(phProvider.state).state.clear();
                              ref.read(salinityProvider.state).state.clear();
                              ref.read(oxygenProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(deadFishesProvider.state).state = [
                                ...e.data!.numberOfDead!
                              ];
                            } else if (v == 'درجات الحراره') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(toxicAmmoniaProvider.state)
                                  .state
                                  .clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref.read(phProvider.state).state.clear();
                              ref.read(salinityProvider.state).state.clear();
                              ref.read(oxygenProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(temperatureProvider.state).state = [
                                ...e.data!.temperature!
                              ];
                            } else if (v == 'ph معدلات') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(toxicAmmoniaProvider.state)
                                  .state
                                  .clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref.read(temperatureProvider.state).state.clear();
                              ref.read(salinityProvider.state).state.clear();
                              ref.read(oxygenProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(phProvider.state).state = [
                                ...e.data!.ph!
                              ];
                            } else if (v == 'الملوحه') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(toxicAmmoniaProvider.state)
                                  .state
                                  .clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref.read(temperatureProvider.state).state.clear();
                              ref.read(phProvider.state).state.clear();
                              ref.read(oxygenProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(salinityProvider.state).state = [
                                ...e.data!.salinity!
                              ];
                            } else if (v == 'الاكسجين') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(toxicAmmoniaProvider.state)
                                  .state
                                  .clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref.read(temperatureProvider.state).state.clear();
                              ref.read(phProvider.state).state.clear();
                              ref.read(salinityProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(oxygenProvider.state).state = [
                                ...e.data!.oxygen!
                              ];
                            } else if (v == 'الامونيا السامه') {
                              ref.read(ammoniaProvider.state).state.clear();
                              ref
                                  .read(averageWeightProvider.state)
                                  .state
                                  .clear();
                              ref
                                  .read(conversionRateProvider.state)
                                  .state
                                  .clear();
                              ref.read(oxygenProvider.state).state.clear();
                              ref.read(deadFishesProvider.state).state.clear();
                              ref.read(temperatureProvider.state).state.clear();
                              ref.read(phProvider.state).state.clear();
                              ref.read(salinityProvider.state).state.clear();
                              ref.read(totalFishesProvider.state).state.clear();
                              ref.read(toxicAmmoniaProvider.state).state = [
                                ...e.data!.oxygen!
                              ];
                            }
                          },
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            if (client.onlinePeriodsResultCount != 0 && ammoniaList.isNotEmpty)
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
            if (client.onlinePeriodsResultCount != 0 &&
                temperatureList.isNotEmpty)
              Directionality(
                textDirection: TextDirection.ltr,
                child: Chart(
                  data: temperatureList,
                ),
              ),
            if (client.onlinePeriodsResultCount != 0 && phList.isNotEmpty)
              Directionality(
                textDirection: TextDirection.ltr,
                child: Chart(
                  data: phList,
                ),
              ),
            if (client.onlinePeriodsResultCount != 0 &&
                toxicAmmoniaList.isNotEmpty)
              Directionality(
                textDirection: TextDirection.ltr,
                child: Chart(
                  data: toxicAmmoniaList,
                ),
              ),
            if (client.onlinePeriodsResultCount != 0 && salinityList.isNotEmpty)
              Directionality(
                textDirection: TextDirection.ltr,
                child: Chart(
                  data: salinityList,
                ),
              ),
            if (client.onlinePeriodsResultCount != 0 && oxygenList.isNotEmpty)
              Directionality(
                textDirection: TextDirection.ltr,
                child: Chart(
                  data: oxygenList,
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
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomTextField(
                                              hint: 'اجمالي وزن السمك بالكيلو',
                                              width:
                                                  SizeConfig.screenWidth * 0.3,
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
                                              width:
                                                  SizeConfig.screenWidth * 0.3,
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
                                              width:
                                                  SizeConfig.screenWidth * 0.1,
                                              hieght: SizeConfig.screenHeight *
                                                  0.05,
                                              radius: 15,
                                              title: ' = ',
                                              function: () {
                                                if (_averageWeight.currentState!
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
                                            hint: 'اجمالي وزن العلف بالكيلو',
                                            calculator: true,
                                            onChange: (v) {
                                              try {
                                                totalFeed = int.parse(v);
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
                                                        .toStringAsFixed(2) +
                                                    ' = معدل النحويل',
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          CustomTextButton(
                                              width:
                                                  SizeConfig.screenWidth * 0.1,
                                              hieght: SizeConfig.screenHeight *
                                                  0.05,
                                              radius: 15,
                                              title: ' = ',
                                              function: () {
                                                if (_conversionRate
                                                    .currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    conversionRate =
                                                        totalFeed / totalWeight;
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
                                              } else if (averageWeight == 0.0) {
                                                HelperFunctions.errorBar(
                                                    context,
                                                    message:
                                                        'يجب عليك اظهار ناتج متوسط الوزن');
                                              } else if (_averageWeight
                                                      .currentState!
                                                      .validate() &&
                                                  _conversionRate.currentState!
                                                      .validate()) {
                                                await updateAndDeletePeriod
                                                    .endPeriod(
                                                        periodId: client
                                                            .onlinePeriodsResult![
                                                                0]
                                                            .id!,
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

                                                pushAndRemoveUntil(MainPage());
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
                                  periodId: client.onlinePeriodsResult![0].id!);
                            }

                            await clients.createPeriod(
                              clientId: client.id!,
                            );

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
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
