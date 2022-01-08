import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';

import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';

import 'package:aquameter/features/Home/presentation/manager/getandDeleteclients_createmettingandperiod_notifier.dart';

import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';

import 'package:aquameter/features/Home/presentation/widgets/days_item.dart';
import 'package:aquameter/features/Home/presentation/pages/search_screen.dart';
import 'package:aquameter/features/profileClient/data/meeting_all_model.dart';
import 'package:aquameter/features/profileClient/presentation/manager/meeting_all_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/pages/profile_client%20_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class Home extends HookConsumerWidget {
  Home({Key? key}) : super(key: key);
  MeetingAllModel? meetingAllModel;
  final FutureProvider<MeetingAllModel> provider =
      FutureProvider<MeetingAllModel>((ref) async {
    return await ref
        .watch(meetingAllNotifier.notifier)
        .meetingAll(); // may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier getClients = ref.read(getClientsNotifier.notifier);
    final MeetingAllNotifier meetingAll = ref.read(meetingAllNotifier.notifier);
    final ValueNotifier<List<MeetingClient>> filterClients =
        useState<List<MeetingClient>>([]);

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
                                filterClients.value = [...e.data!]
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
                                push(SearchScreen());
                              },
                              child: const Text('اضافه عميل'),
                            ),
                          ),
                          filterClients.value.isEmpty
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
                                  itemCount: filterClients.value.length,
                                  itemBuilder: (context, i) => ClientItem(
                                    func: () {
                                      meetingAll.id =
                                          filterClients.value[i].clientId;
                                      push(ProfileClientScreen(
                                        client: filterClients.value[i].client!,
                                        meetingClient: filterClients.value[i]
                                      ));
                                    },
                                    client: filterClients.value[i].client!,
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
