import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import 'package:aquameter/core/utils/widgets/custom_appbar.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/presentation/manager/delete_clients_create_meeting_and_period_notifier.dart';
import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';
import 'package:aquameter/features/profileClient/presentation/pages/add_client.dart';
import 'package:aquameter/features/profileClient/presentation/pages/profile_client_screen.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/routing/route_paths.dart';
import '../../../../core/utils/sizes.dart';
import '../../../../core/utils/widgets/custom_header_title.dart';
import '../../Data/clients_model/client_model.dart';
import 'main_page.dart';

final CustomWarningDialog dialog = CustomWarningDialog();


  final StateProvider<List<Client>> selcetedProvider =
      StateProvider<List<Client>>((ref) => []);
  TextEditingController controller = TextEditingController();
class SearchScreen extends ConsumerStatefulWidget {
  final bool viewProfile;
  final List<Client> clients;
  final WidgetRef ref;

  const SearchScreen({
    Key? key,
    required this.viewProfile,
    required this.clients,
    required this.ref,
  }) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  bool filter = false;
  @override
  void dispose() {
    controller.clear();
    super.dispose();
  }

  List fishes = [];
  @override
  Widget build(BuildContext context) {
    final List<Client> selected = ref.watch(selcetedProvider);

    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    final DeleteClientsCreateMettingAndPeriodNotifier getClient = ref.read(
      deleteAndCreateClientsNotifier.notifier,
    );
    final DeleteClientsCreateMettingAndPeriodNotifier
        getAndDeleteClientsCreateMettingAndPeriod = ref.read(
      deleteAndCreateClientsNotifier.notifier,
    );
    final FishTypesNotifier fishTypes = ref.read(
      fishTypesNotifier.notifier,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.push(context,
              page: const AddClient(
                fromSearch: true,
              ),
              isNamed: false);
        },
        backgroundColor: const Color(0xff91dced),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.fullScreenHeight(context) * 0.2),
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
          )),
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
                color: Colors.black,
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
                      width: Sizes.fullScreenWidth(context) * .17,
                      hieght: Sizes.fullScreenHeight(context) * .05,
                      radius: Sizes.fullScreenWidth(context) * .5,
                      title: 'اظهار الكل',
                      function: () {
                        ref.read(selcetedProvider.state).state = widget.clients;
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
                      width: Sizes.fullScreenWidth(context) * .9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 10),
                          (selected.isNotEmpty)
                              ? ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: selected.length,
                                  itemBuilder: (context, index) => ClientItem(
                                    confirmDismiss:
                                        (DismissDirection direction) async {
                                      return await dialog.showOptionDialog(
                                          context: context,
                                          msg: 'هل ترغب بحذف العميل؟',
                                          okFun: () async {
                                            await getClient.deleteClient(
                                                clientId: selected[index].id!);
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
                                        NavigationService.push(context,
                                            page: ProfileClientScreen(
                                                client: selected[index]),
                                            isNamed: false);
                                      } else {
                                        if (selected[index]
                                            .onlinePeriodsResult!
                                            .isNotEmpty) {
                                          await dialog.showOptionDialog(
                                              context: context,
                                              msg:
                                                  'هل ترغب باضافه العميل للخطه الاسبوعيه ؟',
                                              okFun: () async {
                                                if (selected[index]
                                                        .onlinePeriodsResult![0]
                                                        .meetings!
                                                        .indexWhere((element) =>
                                                            element.meeting!
                                                                .substring(
                                                                    0, 10) ==
                                                            getClient.date) >
                                                    -1) {
                                                  HelperFunctions.errorBar(
                                                      context,
                                                      message:
                                                          'لا يمكن اضافه العميل الي نفس الموعد مرتين');
                                                } else {
                                                  await getClient.createMetting(
                                                    clientId:
                                                        selected[index].id!,
                                                  );
                                                }
                                              },
                                              okMsg: 'نعم',
                                              cancelMsg: 'لا',
                                              cancelFun: () {
                                                return;
                                              });
                                        } else {
                                          await dialog.showOptionDialog(
                                              context: context,
                                              msg: 'هل ترغب باضافة دوره جديده',
                                              okFun: () async {
                                                await getClient
                                                    .createPeriod(
                                                      clientId:
                                                          selected[index].id!,
                                                    )
                                                    .whenComplete(() =>
                                                        NavigationService
                                                            .pushReplacementAll(
                                                          NavigationService
                                                              .context,
                                                          isNamed: true,
                                                          page: RoutePaths
                                                              .homeBase,
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
                                    client: selected[index],
                                  ),
                                )
                              : (selected.isEmpty && controller.text != '')
                                  ? const Center(child: Text('لا يوجد عملاء'))
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
                                              if (widget.viewProfile == true) {
                                                NavigationService.push(context,
                                                    page: ProfileClientScreen(
                                                        client: widget
                                                            .clients[index]),
                                                    isNamed: false);
                                              } else {
                                                if (widget
                                                    .clients[index]
                                                    .onlinePeriodsResult!
                                                    .isNotEmpty) {
                                                  await dialog.showOptionDialog(
                                                      context: context,
                                                      msg:
                                                          'هل ترغب باضافه العميل للخطه الاسبوعيه ؟',
                                                      okFun: () async {
                                                        if (widget
                                                                .clients[index]
                                                                .onlinePeriodsResult![
                                                                    0]
                                                                .meetings!
                                                                .indexWhere((element) =>
                                                                    element
                                                                        .meeting!
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
                                                            clientId: widget
                                                                .clients[index]
                                                                .id!,
                                                          );
                                                          NavigationService
                                                              .pushReplacement(
                                                                  NavigationService
                                                                      .context,
                                                                  page:
                                                                      const MainPage(),
                                                                  isNamed:
                                                                      false);
                                                        }
                                                      },
                                                      okMsg: 'نعم',
                                                      cancelMsg: 'لا',
                                                      cancelFun: () {
                                                        return;
                                                      });
                                                } else {
                                                  await dialog.showOptionDialog(
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
                                                            )
                                                            .whenComplete(() =>
                                                                NavigationService
                                                            .pushReplacementAll(
                                                          NavigationService
                                                              .context,
                                                          isNamed: true,
                                                          page: RoutePaths
                                                              .homeBase,
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
                                            client: widget.clients[index],
                                          ),
                                        ),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
