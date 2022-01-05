import 'dart:developer';

import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/core/utils/widgets/custom_appbar.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';

import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/presentation/manager/get_clients_notifier.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';

import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';
import 'package:aquameter/features/profileClient/presentation/pages/add_client.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchScreen extends HookConsumerWidget {
  SearchScreen({Key? key}) : super(key: key);
  final List<Object> name = [
    'الحاج محمود مصطفي محمد',
    'مهندس محمد طارق عباس',
    'متولي زكريا القاضي',
    'الحاج محمود مصطفي محمد',
    'مهندس محمد طارق عباس',
    'متولي زكريا القاضي',
    'متولي زكريا القاضي',
  ];
  final List<Object> address = [
    'كفرالشيخ - طريق بلطيم الدولي ',
    'بورسعيد - مثلث الديبه',
    'كفرالشيخ - طريق بلطيم الدولي ',
    'بورسعيد - مثلث الديبه',
    'كفرالشيخ - طريق بلطيم الدولي ',
    'بورسعيد - مثلث الديبه',
    'كفرالشيخ - طريق بلطيم الدولي ',
  ];
  final List<Map<String, dynamic>> list = [
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي ',
    },
    {
      "name": 'مهندس محمد طارق عباس',
      "address": 'بورسعيد - مثلث الديبه',
    },
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي',
    },
    {
      "name": 'مهندس محمد طارق عباس',
      "address": 'بورسعيد - مثلث الديبه',
    },
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي',
    },
    {
      "name": 'مهندس محمد طارق عباس',
      "address": 'بورسعيد - مثلث الديبه',
    },
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي',
    },
  ];
  final List<Map<String, dynamic>> listofObject = [
    {'name': 'الغربيه', 'id': 1},
    {'name': 'المنوفية', 'id': 2},
    {'name': 'البحيرة', 'id': 3},
    {'name': 'الاسكندرية', 'id': 4},
    {'name': 'القاهرة', 'id': 5},
    {'name': 'الاسماعيلية', 'id': 6},
    {'name': 'أسيوط', 'id': 7},
    {'name': 'الاقصر', 'id': 8},
    {'name': 'بنى سويف', 'id': 9},
    {'name': 'بورسعيد', 'id': 10},
    {'name': 'دمياط', 'id': 11},
    {'name': 'سوهاج', 'id': 12},
  ];
  final FutureProvider<List<Datum>> provider =
      FutureProvider<List<Datum>>((ref) async {
    return await ref
        .watch(getClientsNotifier.notifier)
        .getClients(); // may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Datum datum;
    final CustomWarningDialog _dialog = CustomWarningDialog();
    final GetClientsNotifier Clients = ref.read(getClientsNotifier.notifier);
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
            child: const CustomAppBar(
              search: true,
              back: true,
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
                  list: listofObject,
                ),
                CustomBottomSheet(
                  name: 'نوع العلف',
                  list: listofObject,
                ),
                CustomBottomSheet(
                  name: 'نوع السمك',
                  list: listofObject,
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
                      ref.watch(provider).when(
                            loading: () => const AppLoader(),
                            error: (e, o) {
                              print(e);
                              print(o);
                              return const Text('error');
                            },
                            data: (e) => ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: e.length,
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
                                        Clients.deleteClient(e[index].id);
                                      },
                                      okMsg: 'نعم',
                                      cancelMsg: 'لا',
                                      cancelFun: () {
                                        return;
                                      });
                                },
                                child: ClientItem(
                                  func: () {
                                    push(const MainPage());
                                  },
                                  datum: e[index],
                                ),
                              ),
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
    );
  }
}
