import 'package:aquameter/core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import 'package:aquameter/core/themes/screen_utility.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';
import 'package:aquameter/features/Home/presentation/manager/get_&_delete_clients_create_meeting_&_period_notifier.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';
import 'package:aquameter/features/Home/presentation/widgets/days_item.dart';
import 'package:aquameter/features/Home/presentation/pages/search_screen.dart';
import 'package:aquameter/features/profileClient/presentation/pages/profile_client%20_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../profileClient/presentation/manager/delete_meeting_notifier.dart';
import '../../Data/clients_model/client_model.dart';

class Home extends ConsumerWidget {
  Home({Key? key}) : super(key: key);

  final FutureProvider<ClientsModel> provider =
      FutureProvider<ClientsModel>((ref) async {
    return await ref
        .watch(getClientsNotifier.notifier)
        .getClients(); //; may cause `provider` to rebuild
  });
  final CustomWarningDialog _dialog = CustomWarningDialog();
  final StateProvider<List<Client>> filterClientsProvider =
      StateProvider<List<Client>>(((ref) => []));
  final List<Client> filterClients2 = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Client> filterClients = ref.watch(filterClientsProvider);
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier getClients =
        ref.read(getClientsNotifier.notifier);
    final DeleteMeetingNotifier deleteMeeting =
        ref.read(meetingAllNotifier.notifier);

    final FishTypesNotifier fishTypes = ref.read(
      fishTypesNotifier.notifier,
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: MainStyle.backGroundColor,
        body: ref.watch(provider).when(
              loading: () => const AppLoader(),
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
                        height: SizeConfig.screenHeight * 0.22,
                        width: SizeConfig.screenWidth * 0.8,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'خطتك هذا الاسبوع',
                                style: MainTheme.headingTextStyle.copyWith(
                                    fontSize: 13, color: Colors.black),
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
                                      e.data![i].onlinePeriodsResult![0]
                                          .meetings!.isNotEmpty) {
                                    for (int x = 0;
                                        x <
                                            e.data![i].onlinePeriodsResult![0]
                                                .meetings!.length;
                                        x++) {
                                      filterClients2.addIf(
                                          e.data![i].onlinePeriodsResult![0]
                                              .meetings![x].meeting!
                                              .startsWith(v),
                                          e.data![i]);
                                    }
                                  }
                                }
                                ref.read(filterClientsProvider.state).state = [
                                  ...filterClients2
                                ];

                                getClients.date = v;
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
                                    push(SearchScreen(
                                      viewProfile: true,
                                      clients: e.data!,
                                      provider: provider,
                                      ref: ref,
                                    ));
                                  }),
                              TextButton(
                                onPressed: () {
                                  push(
                                    SearchScreen(
                                      viewProfile: false,
                                      clients: e.data!,
                                      provider: provider,
                                      ref: ref,
                                    ),
                                  );
                                },
                                child: const Text('اضافه عميل'),
                              ),
                            ],
                          ),
                          filterClients.isEmpty
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
                                  itemCount: filterClients.length,
                                  itemBuilder: (context, i) => ClientItem(
                                    fishTypes: fishTypes,
                                    confirmDismiss:
                                        (DismissDirection direction) async {
                                      return await _dialog.showOptionDialog(
                                          context: context,
                                          msg: 'هل ترغب بحذف العميل؟',
                                          okFun: () async {
                                            final int index = filterClients[i]
                                                .onlinePeriodsResult![0]
                                                .meetings!
                                                .indexWhere((element) =>
                                                    element.meeting!
                                                        .substring(0, 10) ==
                                                    getClients.date);

                                            deleteMeeting.deleteMeeting(
                                                meetingId: filterClients[i]
                                                    .onlinePeriodsResult![0]
                                                    .meetings![index]
                                                    .id!);

                                            pushAndRemoveUntil(MainPage());
                                          },
                                          okMsg: 'نعم',
                                          cancelMsg: 'لا',
                                          cancelFun: () {
                                            return;
                                          });
                                    },
                                    func: () {
                                      push(ProfileClientScreen(
                                        client: filterClients[i],
                                      ));
                                    },
                                    client: filterClients[i],
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
      ),
    );
  }
}
