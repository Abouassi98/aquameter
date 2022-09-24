import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/Data/chart_data_model.dart';
import 'package:aquameter/features/Home/Data/graph_statics_model.dart';
import 'package:aquameter/features/Home/presentation/manager/graph_statics_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/sizes.dart';
import '../../../../core/utils/widgets/app_loader.dart';

import '../../../pdf/presentation/manager/report_notifier.dart';
import '../../../pdf/presentation/pages/genrate_pdf.dart';
import '../manager/get_client_notifier.dart';

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
    StateProvider<DateTime>(((ref) => DateTime.utc(2020, 11, 9)));
final StateProvider<DateTime> dateTimeProvider2 =
    StateProvider<DateTime>(((ref) => DateTime.utc(2022, 11, 9)));
final List fishes2 = [];

final List governorates2 = [];

int clientId = 0;

class Statics extends ConsumerWidget {
  const Statics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? dateTime1 = ref.watch(dateTimeProvider1);
    DateTime? dateTime2 = ref.watch(dateTimeProvider2);

    final List<Fishes> fishes = ref.watch(fishesProvider);
    final List<Governorate> governorates = ref.watch(governorateProvider);
    return ref.watch(getClientsNotifier).data!.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'لا يوجد عملاء',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Lottie.asset(
                'assets/images/noData.json',
                repeat: false,
              ),
            ],
          )
        : ListView(
            children: [
              SizedBox(
                width: Sizes.fullScreenWidth(context) * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: Sizes.fullScreenHeight(context) * .01,
                    ),
                    ref.watch(provider).when(
                            loading: () =>const AppLoader(),
                          error: (e, o) {
                            debugPrint(e.toString());
                            debugPrint(o.toString());
                            return const Text('error');
                          },
                          data: (e) => Center(
                            child: SizedBox(
                              width: Sizes.fullScreenWidth(context) * .5,
                              child: CustomBottomSheet(
                                name: 'الاحصائيات',
                                list: list,
                                staticList: true,
                                onChange: (v) async {
                                  if (v == 'المحافظات') {
                                    governorates2.clear();
                                    fishes2.clear();
                                    ref
                                        .read(governorateProvider.state)
                                        .state
                                        .clear();
                                    ref
                                        .read(fishesProvider.state)
                                        .state
                                        .clear();

                                    for (int i = 0;
                                        i < e.data!.governorate!.length;
                                        i++) {
                                      if (e.data!.governorate![i]
                                              .clientsCount !=
                                          0) {
                                        governorates2
                                            .add(e.data!.governorate![i]);
                                      }
                                    }

                                    ref.read(governorateProvider.state).state =
                                        [...governorates2];
                                  } else {
                                    governorates2.clear();
                                    fishes2.clear();
                                    ref
                                        .read(governorateProvider.state)
                                        .state
                                        .clear();
                                    ref
                                        .read(fishesProvider.state)
                                        .state
                                        .clear();
                                    for (int i = 0;
                                        i < e.data!.fishes!.length;
                                        i++) {
                                      if (e.data!.fishes![i].fishesSumNumber !=
                                          null) {
                                        fishes2.add(e.data!.fishes![i]);
                                      }
                                    }
                                    ref.read(fishesProvider.state).state = [
                                      ...fishes2
                                    ];
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                    SizedBox(
                      height: Sizes.fullScreenHeight(context) * .01,
                    ),
                    if (governorates.isNotEmpty)
                      SfCircularChart(
                          legend: Legend(isVisible: true),
                          series: <CircularSeries>[
                            PieSeries<ChartData, String>(
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(fontSize: 15),
                                borderRadius: 25,
                                color: Colors.white,
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
                                borderRadius: 25,
                                color: Colors.white,
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
                          return;
                        } else {
                          ref.read(dateTimeProvider1.state).state = pickedDate;
                        }
                      });
                    },
                    child: Text(
                      dateTime1 != DateTime.utc(2020, 11, 9)
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
                              initialDate:
                                  dateTime1!.add(const Duration(days: 1)),
                              firstDate: dateTime1.add(const Duration(days: 1)),
                              lastDate: DateTime(2030))
                          .then((pickedDate) {
                        if (pickedDate == null) {
                          return;
                        } else {
                          ref.read(dateTimeProvider2.state).state = pickedDate;
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
                height: Sizes.fullScreenHeight(context) * .01,
              ),
              Center(
                  child: SizedBox(
                      width: Sizes.fullScreenWidth(context) * 0.4,
                      child: CustomBottomSheet(
                        name: 'اختر لعميل',
                        list: ref
                            .watch(getClientsNotifier)
                            .data!
                            .where((element) => element.onlinePeriodsResult!
                                .any((element) =>
                                    element.meetingResults!.isNotEmpty))
                            .toList(),
                        onChange: (v) {
                          clientId = v;
                        },
                      ))),
              SizedBox(
                height: Sizes.fullScreenHeight(context) * .03,
              ),
              Center(
                child: SizedBox(
                  width: Sizes.fullScreenWidth(context) * 0.3,
                  child: CustomTextButton(
                    title: "تحميل التقرير",
                    function: () async {
                      if (clientId != 0) {
                        await ref
                            .read(reportNotifier.notifier)
                            .getReport(
                                start: DateTime.tryParse(
                                  dateTime1.toString().substring(0, 10),
                                ),
                                end: DateTime.tryParse(
                                  dateTime2.toString().substring(0, 10),
                                ),
                                clientId: clientId)
                            .whenComplete(() => PdfGenerator().generatePDF(ref
                                .read(reportNotifier.notifier)
                                .reportModel!
                                .reportData!));
                      } else {
                        HelperFunctions.errorBar(context,
                            message: 'يجب عليك اختيار العميل');
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Sizes.fullScreenHeight(context) * .06,
              ),
            ],
          );
  }
}
