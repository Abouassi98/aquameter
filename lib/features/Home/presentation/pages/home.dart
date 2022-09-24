import 'package:aquameter/core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import 'package:aquameter/core/screens/popup_page.dart';
import 'package:aquameter/core/themes/screen_utility.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/routing/navigation_service.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';
import 'package:aquameter/features/Home/presentation/manager/delete_clients_create_meeting_and_period_notifier.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';
import 'package:aquameter/features/Home/presentation/widgets/days_item.dart';
import 'package:aquameter/features/Home/presentation/pages/search_screen.dart';
import 'package:aquameter/features/profileClient/presentation/pages/profile_client_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/utils/sizes.dart';
import '../../../../core/utils/widgets/app_loader.dart';

import '../../../profileClient/presentation/manager/delete_meeting_notifier.dart';
import '../../Data/clients_model/client_model.dart';
import '../manager/get_client_notifier.dart';

final CustomWarningDialog _dialog = CustomWarningDialog();
final StateProvider<List<Client>> filterClientsProvider =
    StateProvider<List<Client>>(((ref) => []));
final List<Client> filterClients2 = [];

class Home extends ConsumerWidget {
  final AutoDisposeFutureProvider<ClientsModel> provider =
      FutureProvider.autoDispose<ClientsModel>((ref) async {
    return await ref
        .watch(getClientsNotifier.notifier)
        .getClients(); //; may cause `provider` to rebuild
  });

  Home({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopUpPage(
      backgroundColor: MainStyle.backGroundColor,
      body: ref.watch(provider).when(
            loading: () =>const AppLoader(),
            error: (e, o) {
              debugPrint(e.toString());
              debugPrint(o.toString());
              return const Text('error');
            },
            data: (e) => ListView(
              primary: false,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      height: Sizes.fullScreenHeight(context) * 0.16,
                      width: Sizes.fullScreenWidth(context) * 0.8,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'خطتك هذا الاسبوع',
                              style: MainTheme.headingTextStyle
                                  .copyWith(fontSize: 13, color: Colors.black),
                            ),
                          ),
                          Expanded(child: DaysItem(
                            onChaned: (v) {
                              filterClients2.clear();
                              ref
                                  .read(filterClientsProvider.state)
                                  .state
                                  .clear();
                              for (int i = 0; i < e.data!.length; i++) {
                                if (e.data![i].onlinePeriodsResult!
                                        .isNotEmpty &&
                                    e.data![i].onlinePeriodsResult![0].meetings!
                                        .isNotEmpty) {
                                  for (int x = 0;
                                      x <
                                          e.data![i].onlinePeriodsResult![0]
                                              .meetings!.length;
                                      x++) {
                                    if (e.data![i].onlinePeriodsResult![0]
                                        .meetings![x].meeting!
                                        .startsWith(v)) {
                                      filterClients2.add(e.data![i]);
                                    }
                                  }
                                  
                                }
                              }
                              ref.read(filterClientsProvider.state).state = [
                                ...filterClients2
                              ];

                              ref
                                  .read(deleteAndCreateClientsNotifier.notifier)
                                  .date = v;
                            },
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  NavigationService.push(context,
                                      page: SearchScreen(
                                        viewProfile: true,
                                        clients: e.data!,
                                        ref: ref,
                                      ),
                                      isNamed: false);
                                }),
                            TextButton(
                              onPressed: () {
                                NavigationService.push(context,
                                    page: SearchScreen(
                                      viewProfile: false,
                                      clients: e.data!,
                                      ref: ref,
                                    ),
                                    isNamed: false);
                              },
                              child: const Text('اضافه عميل'),
                            ),
                          ],
                        ),
                        ref.watch(filterClientsProvider).isEmpty
                            ? Center(
                                child: Text(
                                  'لايوجد عملاء',
                                  style: MainTheme.headingTextStyle
                                      .copyWith(color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount:
                                    ref.watch(filterClientsProvider).length,
                                itemBuilder: (context, i) => ClientItem(
                                  fishTypes: ref.read(
                                    fishTypesNotifier.notifier,
                                  ),
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await _dialog.showOptionDialog(
                                        context: context,
                                        msg: 'هل ترغب بحذف العميل؟',
                                        okFun: () async {
                                          final int index = ref
                                              .watch(filterClientsProvider)[i]
                                              .onlinePeriodsResult![0]
                                              .meetings!
                                              .indexWhere((element) =>
                                                  element.meeting!
                                                      .substring(0, 10) ==
                                                  ref
                                                      .read(
                                                          deleteAndCreateClientsNotifier
                                                              .notifier)
                                                      .date);

                                          await ref
                                              .read(meetingAllNotifier.notifier)
                                              .deleteMeeting(
                                                  meetingId: ref
                                                      .watch(filterClientsProvider)[
                                                          i]
                                                      .onlinePeriodsResult![0]
                                                      .meetings![index]
                                                      .id!)
                                              .whenComplete(() => Navigator.of(
                                                      context,
                                                      rootNavigator: false)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          fullscreenDialog:
                                                              true,
                                                          maintainState: true,
                                                          builder: (context) =>
                                                              const MainPage()),
                                                      (route) => false));
                                        },
                                        okMsg: 'نعم',
                                        cancelMsg: 'لا',
                                        cancelFun: () {
                                          return;
                                        });
                                  },
                                  func: () {
                                    NavigationService.push(context,
                                        page: ProfileClientScreen(
                                          client: ref
                                              .watch(filterClientsProvider)[i],
                                        ),
                                        isNamed: false);
                                  },
                                  client: ref.watch(filterClientsProvider)[i],
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
