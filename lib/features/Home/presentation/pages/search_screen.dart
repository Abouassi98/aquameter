import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_appbar.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';

import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/presentation/manager/getandDeleteclients_createmettingandperiod_notifier.dart';

import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';
import 'package:aquameter/features/profileClient/presentation/pages/add_client.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'main_page.dart';

// ignore: must_be_immutable
class SearchScreen extends HookConsumerWidget {
  SearchScreen({
    Key? key,
  }) : super(key: key);

  bool filter = false;
  dynamic fishType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = useTextEditingController();

    final ValueNotifier<List<Client>> selected = useState<List<Client>>([]);
    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );

    final CustomWarningDialog _dialog = CustomWarningDialog();
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier clients =
        ref.watch(getClientsNotifier.notifier);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: MainStyle.backGroundColor,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                push(AddClient());
              },
              child: const Icon(
                Icons.add,
                size: 40,
              ),
              backgroundColor: const Color(0xff91dced),
            ),
            appBar: PreferredSize(
                child: CustomAppBar(
                  controller: controller,
                  search: true,
                  back: true,
                  onChanged: (v) {
                    selected.value = [
                      ...clients.clientsModel!.data!
                          .where(
                            (element) => element.name!.startsWith(v.trim()),
                          )
                          .toList()
                    ];
                    debugPrint(selected.value.toString());
                  },
                ),
                preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.2)),
            body: ListView(
              primary: false,
              shrinkWrap: true,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomBottomSheet(
                      name: 'المحافظات',
                      list: areaAndCites.governorateModel!.data!,
                      onChange: (v) {
                        selected.value = [
                          ...clients.clientsModel!.data!
                              .where(
                                (element) => element.governorate!
                                    .toString()
                                    .startsWith(v.toString()),
                              )
                              .toList()
                        ];
                        filter = true;
                      },
                    ),
                    CustomBottomSheet(
                      name: 'نوع السمك',
                      list: ref
                          .read(
                            fishTypesNotifier.notifier,
                          )
                          .fishTypesModel!
                          .data!,
                      onChange: (v) async {
                        selected.value = [
                          ...clients.clientsModel!.data!.where((element) {
                            for (int i = 0; i < element.fish!.length; i++) {
                              fishType = element.fish![i].fishType!.id
                                  .toString()
                                  .startsWith(v.toString());
                            }
                            return fishType;
                          }).toList()
                        ];

                        filter = true;
                      },
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: SizeConfig.screenWidth * .9,
                    child: Card(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 10),
                          (selected.value.isNotEmpty)
                              ? ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: selected.value.length,
                                  itemBuilder: (context, index) => Dismissible(
                                    key: const ValueKey(0),
                                    onDismissed:
                                        (DismissDirection direction) async {
                                      if (direction ==
                                          DismissDirection.startToEnd) {
                                      } else {}
                                    },
                                    confirmDismiss:
                                        (DismissDirection direction) async {
                                      return await _dialog.showOptionDialog(
                                          context: context,
                                          msg: 'هل ترغب بحذف العميل؟',
                                          okFun: () {
                                            clients.deleteClient(
                                                selected.value[index].id);
                                          },
                                          okMsg: 'نعم',
                                          cancelMsg: 'لا',
                                          cancelFun: () {
                                            return;
                                          });
                                    },
                                    child: ClientItem(
                                      func: () async {
                                        await _dialog.showOptionDialog(
                                            context: context,
                                            msg: 'هل ترغب باضافة العميل؟',
                                            okFun: () {
                                              clients.createMetting(
                                                clientId:
                                                    selected.value[index].id!,
                                              );
                                            },
                                            okMsg: 'نعم',
                                            cancelMsg: 'لا',
                                            cancelFun: () {
                                              return;
                                            });
                                      },
                                      client: selected.value[index],
                                    ),
                                  ),
                                )
                              : (selected.value.isEmpty &&
                                      controller.text != '')
                                  ? const Center(child: Text('لا يوجد عملاء'))
                                  : (selected.value.isEmpty &&
                                          controller.text == '' &&
                                          filter == true)
                                      ? const Center(
                                          child: Text('لا يوجد عملاء'))
                                      : ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: clients
                                              .clientsModel!.data!.length,
                                          itemBuilder: (context, index) =>
                                              Dismissible(
                                            key: const ValueKey(0),
                                            onDismissed: (DismissDirection
                                                direction) async {
                                              if (direction ==
                                                  DismissDirection.startToEnd) {
                                              } else {}
                                            },
                                            confirmDismiss: (DismissDirection
                                                direction) async {
                                              return await _dialog
                                                  .showOptionDialog(
                                                      context: context,
                                                      msg:
                                                          'هل ترغب بحذف العميل؟',
                                                      okFun: () {
                                                        clients.deleteClient(
                                                            clients
                                                                .clientsModel!
                                                                .data![index]
                                                                .id);
                                                      },
                                                      okMsg: 'نعم',
                                                      cancelMsg: 'لا',
                                                      cancelFun: () {
                                                        return;
                                                      });
                                            },
                                            child: ClientItem(
                                              func: () async {
                                                await _dialog.showOptionDialog(
                                                    context: context,
                                                    msg:
                                                        'هل ترغب باضافة دوره جديده',
                                                    okFun: () async {
                                                      await clients
                                                          .createPeriod(
                                                        userId: clients
                                                            .clientsModel!
                                                            .data![index]
                                                            .userId,
                                                        clientId: clients
                                                            .clientsModel!
                                                            .data![index]
                                                            .id!,
                                                      );
                                                      await clients
                                                          .createMetting(
                                                        clientId: clients
                                                            .clientsModel!
                                                            .data![index]
                                                            .id!,
                                                      );
                                                      pushAndRemoveUntil(const MainPage());

                                                    },
                                                    okMsg: 'نعم',
                                                    cancelMsg: 'لا',
                                                    cancelFun: () {
                                                      return;
                                                    });
                                              },
                                              client: clients
                                                  .clientsModel!.data![index],
                                            ),
                                          ),
                                        ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
