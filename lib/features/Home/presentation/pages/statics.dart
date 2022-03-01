import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';

import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/pdf/genrate_pdf.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/Data/chart_data_model.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/Data/graph_statics_model.dart';

import 'package:aquameter/features/Home/presentation/manager/graph_statics_notifier.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utils/functions/helper.dart';

class Statics extends HookConsumerWidget {
  final GlobalKey<FormFieldState> _multiSelectKey = GlobalKey<FormFieldState>();

  Statics({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> list = [
    {
      "name": 'المحافظات',
    },
    {
      "name": 'انواع السمك',
    },
  ];

  final FutureProvider<ClientsModel> provider =
      FutureProvider<ClientsModel>((ref) async {
    return await ref
        .read(getClientsNotifier.notifier)
        .getClients(); //; may cause `provider` to rebuild
  });
  final StateProvider<List<Fishes>> fishesProvider =
      StateProvider<List<Fishes>>((ref) => []);
  final StateProvider<List<Governorate>> governorateProvider =
      StateProvider<List<Governorate>>((ref) => []);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Fishes> fishes = ref.watch(fishesProvider);
    final List<Governorate> governorates = ref.watch(governorateProvider);
    final ValueNotifier<DateTime> dateTime1 =
        useState<DateTime>(DateTime.utc(1989, 11, 9));
    final ValueNotifier<DateTime> dateTime2 =
        useState<DateTime>(DateTime.utc(1989, 11, 9));

    ValueNotifier<List<Client>> clientValues = useState<List<Client>>([]);
    final GraphStaticsNotifer graphStatics = ref.read(
      graphStaticsNotifer.notifier,
    );

    return ref.watch(provider).when(
        loading: () => const AppLoader(),
        error: (e, o) {
          debugPrint(e.toString());
          debugPrint(o.toString());
          return const Text('error');
        },
        data: (e) {
          graphStatics.getGraphStatics();
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
                        child: CustomBottomSheet(
                          name: 'الاحصائيات',
                          list: list,
                          staticList: true,
                          onChange: (v) async {
                            if (v == 'المحافظات') {
                              ref.read(fishesProvider.state).state.clear();
                              ref.read(governorateProvider.state).state.clear();

                              for (int i = 0;
                                  i <
                                      graphStatics.graphStaticsModel!.data!
                                          .governorate!.length;
                                  i++) {
                                ref.read(governorateProvider.state).state.addIf(
                                    graphStatics.graphStaticsModel!.data!
                                            .governorate![i].clientsCount !=
                                        0,
                                    graphStatics.graphStaticsModel!.data!
                                        .governorate![i]);
                              }
                            } else {
                              ref.read(governorateProvider.state).state.clear();
                              ref.read(fishesProvider.state).state.clear();
                              for (int i = 0;
                                  i <
                                      graphStatics.graphStaticsModel!.data!
                                          .fishes!.length;
                                  i++) {
                                ref.read(fishesProvider.state).state.addIf(
                                    graphStatics.graphStaticsModel!.data!
                                            .fishes![i].fishesSumNumber !=
                                        null,
                                    graphStatics
                                        .graphStaticsModel!.data!.fishes![i]);
                              }
                            }
                          },
                        ),
                      ),
                    ),
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
                              initialDate: DateTime(2022),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2030))
                          .then((pickedDate) {
                        if (pickedDate == null) {
                          //if user tap cancel then this function will stop
                          return;
                        } else {
                          dateTime1.value = pickedDate;
                          if (dateTime1.value
                                  .difference(dateTime2.value)
                                  .inDays >
                              0) {
                            dateTime2.value = DateTime.utc(1989, 11, 9);
                          }
                        }
                      });
                    },
                    child: Text(
                      dateTime1.value != DateTime.utc(1989, 11, 9)
                          ? dateTime1.value.toString().substring(0, 10)
                          : 'من',
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  const Text(':'),
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: dateTime1.value,
                              firstDate: dateTime1.value,
                              lastDate: DateTime(2030))
                          .then((pickedDate) {
                        if (pickedDate == null) {
                          //if user tap cancel then this function will stop
                          return;
                        } else {
                          dateTime2.value = pickedDate;
                        }
                      });
                    },
                    child: Text(
                      dateTime2.value != DateTime.utc(1989, 11, 9)
                          ? dateTime2.value.toString().substring(0, 10)
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
                    width: SizeConfig.screenWidth * 0.6,
                    child: MultiSelectBottomSheetField(
                      key: _multiSelectKey,
                      buttonIcon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 10,
                      ),
                      cancelText: const Text('الغاء'),
                      confirmText: const Text('موافق'),
                      listType: MultiSelectListType.LIST,
                      initialChildSize: 0.7,
                      maxChildSize: 0.95,
                      title: Padding(
                        padding:
                            EdgeInsets.only(left: SizeConfig.screenWidth * .4),
                        child: CustomTextButton(
                            hieght: SizeConfig.screenHeight * .04,
                            width: SizeConfig.screenWidth * .2,
                            title: 'تحديد الكل',
                            function: () {
                              clientValues.value = e.data!;
                              pop();
                              HelperFunctions.successBar(context,
                                  message: 'تم اختيار الكل');
                            }),
                      ),
                      buttonText: const Text(
                        'اختار العميل',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      items: e.data!
                          .map((e) => MultiSelectItem(e, e.name!))
                          .toList(),
                      searchable: true,
                      onConfirm: (values) async {
                        clientValues.value = values.cast();
                        debugPrint('sdfsfdsfd  ${values.first}');
                        if (values.isNotEmpty) {
                        } else {}

                        _multiSelectKey.currentState!.validate();
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        alignment: Alignment.topRight,
                        onTap: (item) {
                          _multiSelectKey.currentState!.validate();
                        },
                      ),
                    )),
              ),
              SizedBox(
                height: context.height * .03,
              ),
              Center(
                child: SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    child: CustomTextButton(
                        title: "تحميل التقرير",
                        function: () async {
                          PdfGenerator()
                              .generatePDF(clients: clientValues.value);
                        })),
              ),
              SizedBox(
                height: context.height * .06,
              ),
            ],
          );
        });
  }
}
