import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/core/utils/widgets/custom_appbar.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';
import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/presentation/manager/get_&_delete_clients_create_metting_&_period_notifier.dart';
import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';
import 'package:aquameter/features/profileClient/presentation/manager/meeting_all_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/pages/add_client.dart';
import 'package:aquameter/features/profileClient/presentation/pages/profile_client%20_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/utils/widgets/custom_headear_title.dart';
import 'main_page.dart';

// ignore: must_be_immutable
class SearchScreen extends HookConsumerWidget {
  final bool viewProfile;
  SearchScreen({Key? key, required this.viewProfile}) : super(key: key);
  bool filter = false;
  dynamic fishType;
  final FutureProvider<ClientsModel> provider =
      FutureProvider<ClientsModel>((ref) async {
    return await ref
        .watch(getClientsNotifier.notifier)
        .getClients(); //; may cause `provider` to rebuild
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = useTextEditingController();
    final ValueNotifier<List<Client>> selected = useState<List<Client>>([]);
    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier
        getAndDeleteClientsCreateMettingAndPeriod = ref.read(
      getClientsNotifier.notifier,
    );
    final MeetingAllNotifier meetingAll = ref.read(meetingAllNotifier.notifier);
    final FishTypesNotifier fishTypes = ref.read(
      fishTypesNotifier.notifier,
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
                        (element) =>
                            element.name!.startsWith(v.toLowerCase().trim()),
                      )
                      .toList()
                ];
                debugPrint(selected.value.toString());
              },
            ),
            preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.2)),
        body: ref.watch(provider).when(
              loading: () => const Scaffold(body: AppLoader()),
              error: (e, o) {
                debugPrint(e.toString());
                debugPrint(o.toString());
                return const Text('error');
              },
              data: (e) => RefreshIndicator(
                onRefresh: () async {
                  return await ref.refresh(provider);
                },
                child: SingleChildScrollView(
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: CustomHeaderTitle(
                          title: viewProfile == true
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
                              selected.value = [
                                ...e.data!
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
                                ...e.data!.where((element) {
                                  for (int i = 0;
                                      i < element.fish!.length;
                                      i++) {
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
                                        itemBuilder: (context, index) =>
                                            ClientItem(
                                          confirmDismiss: (DismissDirection
                                              direction) async {
                                            return await _dialog
                                                .showOptionDialog(
                                                    context: context,
                                                    msg: 'هل ترغب بحذف العميل؟',
                                                    okFun: () async {
                                                      await clients
                                                          .deleteClient(
                                                              clientId: selected
                                                                  .value[index]
                                                                  .id!);
                                                      ref.refresh(provider);
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
                                            if (viewProfile == true) {
                                              meetingAll.id =
                                                  selected.value[index].id;
                                              push(
                                                ProfileClientScreen(
                                                    client:
                                                        selected.value[index]),
                                              );
                                            } else {
                                              await _dialog.showOptionDialog(
                                                  context: context,
                                                  msg: 'هل ترغب باضافة العميل؟',
                                                  okFun: () {
                                                    clients.createMetting(
                                                      clientId: selected
                                                          .value[index].id!,
                                                    );
                                                  },
                                                  okMsg: 'نعم',
                                                  cancelMsg: 'لا',
                                                  cancelFun: () {
                                                    return;
                                                  });
                                            }
                                          },
                                          client: selected.value[index],
                                        ),
                                      )
                                    : (selected.value.isEmpty &&
                                            controller.text != '')
                                        ? const Center(
                                            child: Text('لا يوجد عملاء'))
                                        : (selected.value.isEmpty &&
                                                controller.text == '' &&
                                                filter == true)
                                            ? const Center(
                                                child: Text('لا يوجد عملاء'))
                                            : ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: e.data!.length,
                                                itemBuilder: (context, index) =>
                                                    ClientItem(
                                                  confirmDismiss:
                                                      (DismissDirection
                                                          direction) async {
                                                    return await _dialog
                                                        .showOptionDialog(
                                                            context: context,
                                                            msg:
                                                                'هل ترغب بحذف العميل؟',
                                                            okFun: () async {
                                                              await clients
                                                                  .deleteClient(
                                                                      clientId: e
                                                                          .data![
                                                                              index]
                                                                          .id!);
                                                              ref.refresh(
                                                                  provider);

                                                              // pushReplacement(
                                                              // //     SearchScreen(
                                                              // //   viewProfile:
                                                              // //       viewProfile,
                                                              // // ));
                                                            },
                                                            okMsg: 'نعم',
                                                            cancelMsg: 'لا',
                                                            cancelFun: () {
                                                              return;
                                                            });
                                                  },
                                                  fishTypes: fishTypes,
                                                  func: () async {
                                                    if (viewProfile == true) {
                                                      meetingAll.id =
                                                          e.data![index].id;
                                                      push(ProfileClientScreen(
                                                          client:
                                                              e.data![index]));
                                                    } else {
                                                      if (clients
                                                          .clientsModel!
                                                          .data![index]
                                                          .onlinePeriodsResult!
                                                          .isNotEmpty) {
                                                        await _dialog
                                                            .showOptionDialog(
                                                                context:
                                                                    context,
                                                                msg:
                                                                    'هل ترغب باضافه العميل للخطه الاسبوعيه ؟',
                                                                okFun:
                                                                    () async {
                                                                  await clients
                                                                      .createMetting(
                                                                    clientId: e
                                                                        .data![
                                                                            index]
                                                                        .id!,
                                                                  );
                                                                  pushAndRemoveUntil(
                                                                      const MainPage());
                                                                },
                                                                okMsg: 'نعم',
                                                                cancelMsg: 'لا',
                                                                cancelFun: () {
                                                                  return;
                                                                });
                                                      } else {
                                                        await _dialog
                                                            .showOptionDialog(
                                                                context:
                                                                    context,
                                                                msg:
                                                                    'هل ترغب باضافة دوره جديده',
                                                                okFun:
                                                                    () async {
                                                                  await clients
                                                                      .createPeriod(
                                                                    clientId: e
                                                                        .data![
                                                                            index]
                                                                        .id!,
                                                                  );

                                                                  pop();
                                                                  push(
                                                                      ProfileClientScreen(
                                                                    client:
                                                                        e.data![
                                                                            index],
                                                                  ));
                                                                },
                                                                okMsg: 'نعم',
                                                                cancelMsg: 'لا',
                                                                cancelFun: () {
                                                                  return;
                                                                });
                                                      }
                                                    }
                                                  },
                                                  client: e.data![index],
                                                ),
                                              ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
