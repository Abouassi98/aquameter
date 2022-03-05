import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';

import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/Data/chart_data_model.dart';
import 'package:aquameter/features/Home/Data/graph_statics_model.dart';
import 'package:aquameter/features/Home/presentation/manager/graph_statics_notifier.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utils/functions/helper_functions.dart';

import '../../../pdf/presentation/manager/report_notifier.dart';
import '../../../pdf/presentation/pages/genrate_pdf.dart';

import '../manager/get_&_delete_clients_create_meeting_&_period_notifier.dart';

// ignore: must_be_immutable
class Statics extends ConsumerWidget {
  // final GlobalKey<FormFieldState> _multiSelectKey = GlobalKey<FormFieldState>();

  Statics({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> list = [
    {
      "name": 'المحافظات',
    },
    {
      "name": 'انواع السمك',
    },
  ];

  final AutoDisposeFutureProvider<GraphStaticsModel> provider =
      FutureProvider.autoDispose<GraphStaticsModel>((ref) async {
    return await ref
        .watch(graphStaticsNotifer.notifier)
        .getGraphStatics(); //; may cause `provider` to rebuild
  });
  final StateProvider<List<Fishes>> fishesProvider =
      StateProvider<List<Fishes>>((ref) => []);
  final StateProvider<List<Governorate>> governorateProvider =
      StateProvider<List<Governorate>>((ref) => []);

  final StateProvider<DateTime> dateTimeProvider1 =
      StateProvider<DateTime>(((ref) => DateTime.utc(1989, 11, 9)));
  final StateProvider<DateTime> dateTimeProvider2 =
      StateProvider<DateTime>(((ref) => DateTime.utc(2022, 11, 9)));
  final List fishes2 = [];

  final List governorates2 = [];

  StateProvider<int> clientValuesProvider = StateProvider<int>((ref) => 0);
  StateProvider<bool> filterProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int clientValues = ref.watch(clientValuesProvider);
    bool filter = ref.watch(filterProvider);
    DateTime dateTime1 = ref.watch(dateTimeProvider1);
    DateTime dateTime2 = ref.watch(dateTimeProvider2);

    final List<Fishes> fishes = ref.watch(fishesProvider);
    final List<Governorate> governorates = ref.watch(governorateProvider);

 
          return ListView(
            children: [
              SizedBox(
                width: context.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * .01,
                    ),
                    ref.watch(provider).when(
        loading: () => const AppLoader(),
        error: (e, o) {
          debugPrint(e.toString());
          debugPrint(o.toString());
          return const Text('error');
        },data: (e)=> Center(
                      child: SizedBox(
                        width: context.width * .5,
                        child: CustomBottomSheet(
                          name: 'الاحصائيات',
                          list: list,
                          staticList: true,
                          onChange: (v) async {
                            if (v == 'المحافظات') {
                              governorates2.clear();
                              fishes2.clear();
                              ref.read(governorateProvider.state).state.clear();
                              ref.read(fishesProvider.state).state.clear();

                              for (int i = 0;
                                  i < e.data!.governorate!.length;
                                  i++) {
                                governorates2.addIf(
                                    e.data!.governorate![i].clientsCount != 0,
                                    e.data!.governorate![i]);
                              }
                              ref.read(governorateProvider.state).state = [
                                ...governorates2
                              ];
                            } else {
                              governorates2.clear();
                              fishes2.clear();
                              ref.read(governorateProvider.state).state.clear();
                              ref.read(fishesProvider.state).state.clear();
                              for (int i = 0; i < e.data!.fishes!.length; i++) {
                                fishes2.addIf(
                                    e.data!.fishes![i].fishesSumNumber != null,
                                    e.data!.fishes![i]);
                              }
                              ref.read(fishesProvider.state).state = [
                                ...fishes2
                              ];
                            }
                          },
                        ),
                      ),
                    ),),
                   
                    SizedBox(
                      height: SizeConfig.screenHeight * .01,
                    ),
                    if (governorates.isNotEmpty)
                      SfCircularChart(
                          legend: Legend(isVisible: true),
                          series: <CircularSeries>[
                            PieSeries<ChartData, String>(
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(fontSize: 15),
                                color: Colors.red,
                                labelPosition: ChartDataLabelPosition.inside,
                              ),
                              dataSource: List.generate(
                                governorates.length,
                                (i) => ChartData(
                                  governorates[i].names!,
                                  governorates[i].clientsCount!,
                                ),
                              ),
                              legendIconType: LegendIconType.circle,
                              xValueMapper: (ChartData data, _) => data.name,
                              yValueMapper: (ChartData data, _) => data.count,
                            )
                          ]),
                    if (fishes.isNotEmpty)
                      SfCircularChart(
                          legend: Legend(isVisible: true),
                          series: <CircularSeries>[
                            PieSeries<ChartData, String>(
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(fontSize: 15),
                                color: Colors.red,
                                labelPosition: ChartDataLabelPosition.inside,
                              ),
                              dataSource: List.generate(
                                fishes.length,
                                (i) => ChartData(
                                  fishes[i].name!,
                                  fishes[i].fishesSumNumber!,
                                ),
                              ),
                              legendIconType: LegendIconType.circle,
                              xValueMapper: (ChartData data, _) => data.name,
                              yValueMapper: (ChartData data, _) => data.count,
                            )
                          ]),
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                2022,
                              ),
                              lastDate: DateTime(2030))
                          .then((pickedDate) {
                        if (pickedDate == null) {
                          //if user tap cancel then this function will stop
                          return;
                        } else {
                          // debugPrint(
                          // "kk" + pickedDate.toString().substring(0, 10));

                          ref.read(dateTimeProvider1.state).state = pickedDate;
                          // // debugPrint("kk"+dateTime1.toString().substring(0, 10));
                          // ref.read(reportNotifier.notifier).getReport(
                          //       start: DateTime.tryParse(
                          //         dateTime1.toString().substring(0, 10),
                          //       ),
                          //     );

                          // if (dateTime1.difference(dateTime2).inDays > 0) {
                          //   // ref.read(dateTimeProvider2.state).state =
                          //   //     DateTime.utc(1989, 11, 9);
                          // }
                        }
                      });
                    },
                    child: Text(
                      dateTime1 != DateTime.utc(1989, 11, 9)
                          ? dateTime1.toString().substring(0, 10)
                          : 'من',
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  const Text(':'),
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                2022,
                              ),
                              lastDate: DateTime(2030))
                          .then((pickedDate) {
                        if (pickedDate == null) {
                          //if user tap cancel then this function will stop
                          return;
                        } else {
                          ref.read(dateTimeProvider2.state).state = pickedDate;
                          // ref.read(reportNotifier.notifier).getReport(
                          //       end: DateTime.tryParse(
                          //         dateTime2.toString().substring(0, 10),
                          //       ),
                          //     );
                        }
                      });
                    },
                    child: Text(
                      dateTime2 != DateTime.utc(2022, 11, 9)
                          ? dateTime2.toString().substring(0, 10)
                          : 'الي',
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.height * .01,
              ),
              Center(
                  child: SizedBox(
                      width: SizeConfig.screenWidth * 0.4,
                      child: CustomBottomSheet(
                        name: 'اختر لعميل',
                        list: ref
                            .watch(getClientsNotifier.notifier)
                            .clientsModel!
                            .data!
                            .where((element) => element.onlinePeriodsResult!
                                .first.meetingResults!.isNotEmpty)
                            .toList(),
                        onChange: (v) {
                          ref.read(filterProvider.state).state = true;

                          ref.read(clientValuesProvider.state).state = v;
                          // ref
                          //     .read(reportNotifier.notifier)
                          //     .getReport(clientId: v);
                        },
                      )
                      // MultiSelectBottomSheetField(
                      //   key: _multiSelectKey,
                      //   buttonIcon: const Icon(
                      //     Icons.arrow_back_ios_new,
                      //     size: 10,
                      //   ),
                      //   cancelText: const Text('الغاء'),
                      //   confirmText: const Text('موافق'),
                      //   listType: MultiSelectListType.LIST,
                      //   initialChildSize: 0.7,
                      //   maxChildSize: 0.95,
                      //   title: Padding(
                      //     padding: EdgeInsets.only(
                      //         left: SizeConfig.screenWidth * .4),
                      //     child: CustomTextButton(
                      //         hieght: SizeConfig.screenHeight * .04,
                      //         width: SizeConfig.screenWidth * .2,
                      //         title: 'تحديد الكل',
                      //         function: () {
                      //           ref.read(clientValuesProvider.state).state =
                      //           e.reportData!;
                      //           pop();
                      //           HelperFunctions.successBar(context,
                      //               message: 'تم اختيار الكل');
                      //         }),
                      //   ),
                      //   buttonText: const Text(
                      //     'اختار العميل',
                      //     style: TextStyle(
                      //       fontSize: 10,
                      //     ),
                      //   ),
                      //   items: e.data!
                      //       .map((e) => MultiSelectItem(e, e.name!))
                      //       .toList(),
                      //   searchable: true,
                      //   onConfirm: (values) async {
                      //     ref.read(clientValuesProvider.state).state =
                      //         values.cast();
                      //     debugPrint('sdfsfdsfd  ${values.first}');
                      //     if (values.isNotEmpty) {
                      //     } else {}
                      //
                      //     _multiSelectKey.currentState!.validate();
                      //   },
                      //   chipDisplay: MultiSelectChipDisplay(
                      //     alignment: Alignment.topRight,
                      //     onTap: (item) {
                      //       _multiSelectKey.currentState!.validate();
                      //     },
                      //   ),
                      // ))
                      )),
              SizedBox(
                height: context.height * .03,
              ),
              Center(
                child: SizedBox(
                  width: SizeConfig.screenWidth * 0.3,
                  child: CustomTextButton(
                    title: "تحميل التقرير",
                    function: () async {
                      debugPrint('kk' +
                          ref
                              .watch(reportNotifier.notifier)
                              .reportModel!
                              .reportData!
                              .length
                              .toString());

                      if (filter) {
                        await ref.read(reportNotifier.notifier).getReport(
                            start: DateTime.tryParse(
                              dateTime1.toString().substring(0, 10),
                            ),
                            end: DateTime.tryParse(
                              dateTime2.toString().substring(0, 10),
                            ),
                            clientId: clientValues);
                        PdfGenerator().generatePDF(ref
                                .watch(reportNotifier.notifier)
                                .reportModel!
                                .reportData!
                            // .where(
                            //     (element) => element.clientId == clientValues)
                            // .toList()
                            );
                      } else {
                        HelperFunctions.errorBar(context,
                            message: 'يجب عليك اختيار العميل');
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: context.height * .06,
              ),
            ],
          );
  
  }
}
