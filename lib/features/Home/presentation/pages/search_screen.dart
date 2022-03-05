import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import 'package:aquameter/core/themes/screen_utility.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';

import 'package:aquameter/core/utils/widgets/custom_appbar.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';

import 'package:aquameter/features/Home/presentation/manager/get_&_delete_clients_create_meeting_&_period_notifier.dart';
import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';
import 'package:aquameter/features/profileClient/presentation/pages/add_client.dart';
import 'package:aquameter/features/profileClient/presentation/pages/profile_client%20_screen.dart';
import '../../../../core/utils/widgets/custom_header_title.dart';
import '../../Data/clients_model/client_model.dart';
import 'main_page.dart';

// ignore: must_be_immutable
class SearchScreen extends ConsumerStatefulWidget {
  final bool viewProfile;
  final List<Client> clients;
  final WidgetRef ref;
  final FutureProvider<ClientsModel> provider;
  const SearchScreen(
      {Key? key,
      required this.viewProfile,
      required this.clients,
      required this.ref,
      required this.provider})
      : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  bool filter = false;

  final StateProvider<List<Client>> selcetedProvider =
      StateProvider<List<Client>>((ref) => []);
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List fishes = [];
  @override
  Widget build(BuildContext context) {
    final List<Client> selected = ref.watch(selcetedProvider);

    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier getClient =
        ref.read(
      getClientsNotifier.notifier,
    );
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier
        getAndDeleteClientsCreateMettingAndPeriod = ref.read(
      getClientsNotifier.notifier,
    );
    final FishTypesNotifier fishTypes = ref.read(
      fishTypesNotifier.notifier,
    );
    final CustomWarningDialog _dialog = CustomWarningDialog();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: MainStyle.backGroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            push(AddClient(
              fromSearch: true,
            ));
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
                ref.read(selcetedProvider.state).state = [
                  ...widget.clients
                      .where(
                        (element) =>
                            element.name!.startsWith(v.toLowerCase().trim()),
                      )
                      .toList()
                ];
                debugPrint(selected.toString());
              },
            ),
            preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.2)),
        body: SingleChildScrollView(
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CustomHeaderTitle(
                  title: widget.viewProfile == true
                      ? 'عرض العملاء'
                      : 'اضافه عميل في الخطه ليوم ${getAndDeleteClientsCreateMettingAndPeriod.date}',
                  color: Colors.blue[400],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomBottomSheet(
                    name: 'المحافظات',
                    list: areaAndCites.governorateModel!.data!,
                    onChange: (v) {
                      ref.read(selcetedProvider.state).state = [
                        ...widget.clients
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
                      ref.read(selcetedProvider.state).state = [
                        ...widget.clients
                            .where(
                                (element) => element.fish![0].fishType!.id == v)
                            .toList()
                      ];

                      filter = true;
                    },
                  ),
                  if (filter)
                    CustomTextButton(
                        width: SizeConfig.screenWidth * .17,
                        hieght: SizeConfig.screenHeight * .05,
                        radius: SizeConfig.screenWidth * .5,
                        title: 'اظهار الكل',
                        function: () {
                          ref.read(selcetedProvider.state).state =
                              widget.clients;
                          filter = false;
                        }),
                ],
              ),
              widget.clients.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'لا يوجد عملاء',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Lottie.asset(
                          'assets/images/noData.json',
                          repeat: false,
                        ),
                      ],
                    )
                  : Center(
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
                              (selected.isNotEmpty)
                                  ? ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: selected.length,
                                      itemBuilder: (context, index) =>
                                          ClientItem(
                                        confirmDismiss:
                                            (DismissDirection direction) async {
                                          return await _dialog.showOptionDialog(
                                              context: context,
                                              msg: 'هل ترغب بحذف العميل؟',
                                              okFun: () async {
                                                await getClient.deleteClient(
                                                    clientId:
                                                        selected[index].id!);

                                                // pushReplacement(SearchScreen(
                                                //   viewProfile: viewProfile,
                                                // ));
                                              },
                                              okMsg: 'نعم',
                                              cancelMsg: 'لا',
                                              cancelFun: () {
                                                return;
                                              });
                                        },
                                        fishTypes: fishTypes,
                                        func: () async {
                                          if (widget.viewProfile == true) {
                                            push(
                                              ProfileClientScreen(
                                                  client: selected[index]),
                                            );
                                          } else {
                                            if (selected[index]
                                                .onlinePeriodsResult!
                                                .isNotEmpty) {
                                              await _dialog.showOptionDialog(
                                                  context: context,
                                                  msg:
                                                      'هل ترغب باضافه العميل للخطه الاسبوعيه ؟',
                                                  okFun: () async {
                                                    if (selected[index]
                                                            .onlinePeriodsResult![
                                                                0]
                                                            .meetings!
                                                            .indexWhere((element) =>
                                                                element.meeting!
                                                                    .substring(
                                                                        0,
                                                                        10) ==
                                                                getClient
                                                                    .date) >
                                                        -1) {
                                                      HelperFunctions.errorBar(
                                                          context,
                                                          message:
                                                              'لا يمكن اضافه العميل الي نفس الموعد مرتين');
                                                    } else {
                                                      await getClient
                                                          .createMetting(
                                                        clientId:
                                                            selected[index].id!,
                                                      );
                                                      pushAndRemoveUntil(
                                                          MainPage());
                                                    }
                                                  },
                                                  okMsg: 'نعم',
                                                  cancelMsg: 'لا',
                                                  cancelFun: () {
                                                    return;
                                                  });
                                            } else {
                                              await _dialog.showOptionDialog(
                                                  context: context,
                                                  msg:
                                                      'هل ترغب باضافة دوره جديده',
                                                  okFun: () async {
                                                    await getClient
                                                        .createPeriod(
                                                      clientId:
                                                          selected[index].id!,
                                                    );

                                                    pop();
                                                  },
                                                  okMsg: 'نعم',
                                                  cancelMsg: 'لا',
                                                  cancelFun: () {
                                                    return;
                                                  });
                                            }
                                          }
                                        },
                                        client: selected[index],
                                      ),
                                    )
                                  : (selected.isEmpty && controller.text != '')
                                      ? const Center(
                                          child: Text('لا يوجد عملاء'))
                                      : (selected.isEmpty &&
                                              controller.text == '' &&
                                              filter == true)
                                          ? const Center(
                                              child: Text('لا يوجد عملاء'))
                                          : ListView.builder(
                                              primary: false,
                                              shrinkWrap: true,
                                              itemCount: widget.clients.length,
                                              itemBuilder: (context, index) =>
                                                  ClientItem(
                                                fishTypes: fishTypes,
                                                func: () async {
                                                  if (widget.viewProfile ==
                                                      true) {
                                                    push(ProfileClientScreen(
                                                        client: widget
                                                            .clients[index]));
                                                  } else {
                                                    if (widget
                                                        .clients[index]
                                                        .onlinePeriodsResult!
                                                        .isNotEmpty) {
                                                      await _dialog
                                                          .showOptionDialog(
                                                              context: context,
                                                              msg:
                                                                  'هل ترغب باضافه العميل للخطه الاسبوعيه ؟',
                                                              okFun: () async {
                                                                if (widget
                                                                        .clients[
                                                                            index]
                                                                        .onlinePeriodsResult![
                                                                            0]
                                                                        .meetings!
                                                                        .indexWhere((element) =>
                                                                            element.meeting!.substring(0,
                                                                                10) ==
                                                                            getClient.date) >
                                                                    -1) {
                                                                  HelperFunctions
                                                                      .errorBar(
                                                                          context,
                                                                          message:
                                                                              'لا يمكن اضافه العميل الي نفس الموعد مرتين');
                                                                } else {
                                                                  await getClient
                                                                      .createMetting(
                                                                    clientId: widget
                                                                        .clients[
                                                                            index]
                                                                        .id!,
                                                                  );
                                                                  pushAndRemoveUntil(
                                                                      MainPage());
                                                                }
                                                              },
                                                              okMsg: 'نعم',
                                                              cancelMsg: 'لا',
                                                              cancelFun: () {
                                                                return;
                                                              });
                                                    } else {
                                                      await _dialog
                                                          .showOptionDialog(
                                                              context: context,
                                                              msg:
                                                                  'هل ترغب باضافة دوره جديده',
                                                              okFun: () async {
                                                                await getClient
                                                                    .createPeriod(
                                                                  clientId: widget
                                                                      .clients[
                                                                          index]
                                                                      .id!,
                                                                );

                                                                pop();
                                                              },
                                                              okMsg: 'نعم',
                                                              cancelMsg: 'لا',
                                                              cancelFun: () {
                                                                return;
                                                              });
                                                    }
                                                  }
                                                },
                                                client: widget.clients[index],
                                              ),
                                            ),
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
