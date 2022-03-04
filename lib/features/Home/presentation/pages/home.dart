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

import 'package:aquameter/features/profileClient/presentation/manager/meeting_all_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/pages/profile_client%20_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profileClient/data/meeting_all_model..dart';
import '../../../profileClient/presentation/manager/profile_graph_notifier.dart';

class Home extends ConsumerWidget {
  Home({Key? key}) : super(key: key);

  final AutoDisposeFutureProvider<MeetingAllModel> provider =
      FutureProvider.autoDispose<MeetingAllModel>((ref) async {
    return await ref
        .watch(meetingAllNotifier.notifier)
        .meetingAll(); // may cause `provider` to rebuild
  });
  final CustomWarningDialog _dialog = CustomWarningDialog();
  final StateProvider<List<MeetingClient>> filterClientsProvider =
      StateProvider<List<MeetingClient>>(((ref) => []));
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MeetingClient> filterClients = ref.watch(filterClientsProvider);
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier getClients =
        ref.read(getClientsNotifier.notifier);
    final MeetingAllNotifier meetingAll = ref.read(meetingAllNotifier.notifier);
    final ProfileClientNotifer profileClient =
        ref.read(profileClientNotifer.notifier);
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
                                ref.read(filterClientsProvider.state).state =
                                    [...e.data!]
                                        .where(
                                          (element) =>
                                              element.meeting!.startsWith(v),
                                        )
                                        .toList();

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
                          Container(
                            width: SizeConfig.screenHeight,
                            alignment: Alignment.bottomLeft,
                            child: TextButton(
                              onPressed: () {
                                push(
                                  const SearchScreen(
                                    viewProfile: false,
                                  ),
                                );
                              },
                              child: const Text('اضافه عميل'),
                            ),
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
                                            meetingAll.deleteMeeting(
                                                meetingId:
                                                    filterClients[i].id!);

                                            pushAndRemoveUntil(MainPage());
                                          },
                                          okMsg: 'نعم',
                                          cancelMsg: 'لا',
                                          cancelFun: () {
                                            return;
                                          });
                                    },
                                    func: () {
                                      profileClient.clientId =
                                          filterClients[i].clientId;
                                      push(ProfileClientScreen(
                                        fromSearch: false,
                                        client: filterClients[i].client!,
                                      ));
                                    },
                                    client: filterClients[i].client!,
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
