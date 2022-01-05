import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
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
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchScreen extends HookConsumerWidget {
  SearchScreen({Key? key}) : super(key: key);



  final FutureProvider<List<Datum>> provider =
      FutureProvider<List<Datum>>((ref) async {
    return await ref
        .watch(getClientsNotifier.notifier)
        .getClients(); // may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = useTextEditingController();

    final ValueNotifier<List<Datum>> selected = useState<List<Datum>>([]);
    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    ValueNotifier<List<Datum>> listOfCities = useState<List<Datum>>([]);


    final CustomWarningDialog _dialog = CustomWarningDialog();
    final GetClientsNotifier clients = ref.watch(getClientsNotifier.notifier);
    return ref.watch(provider).when(
          loading: () => const AppLoader(),
          error: (e, o) {
            debugPrint(e.toString());
            debugPrint(o.toString());
            return const Text('error');
          },
          data: (e) => Directionality(
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
                        ...e
                            .where(
                              (element) => element.name!.startsWith(v.trim()),
                            )
                            .toList()
                      ];
                      debugPrint(selected.value.toString());
                    },
                  ),
                  preferredSize:
                      Size.fromHeight(SizeConfig.screenHeight * 0.2)),
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
                        list: areaAndCites.citiesModel!.data!,
                        onChange: (v) async {
                          await clients.getClients(cityId: v);

                        },
                      ),
                      CustomBottomSheet(
                        name: 'نوع العلف',
                        list: areaAndCites.citiesModel!.data!,
                      ),
                      CustomBottomSheet(
                        name: 'نوع السمك',
                        list: ref
                            .read(
                              fishTypesNotifier.notifier,
                            )
                            .fishTypesModel!
                            .data!,
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
                            (selected.value.isNotEmpty && controller.text != '')
                                ? ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: selected.value.length,
                                    itemBuilder: (context, index) =>
                                        Dismissible(
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
                                        func: () {
                                          push(const MainPage());
                                        },
                                        datum: selected.value[index],
                                      ),
                                    ),
                                  )
                                : (selected.value.isEmpty &&
                                        controller.text != '')
                                    ? const Center(
                                        child: Text('لا يوجد منتجات'))
                                    : ListView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: e.length,
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
                                                    msg: 'هل ترغب بحذف العميل؟',
                                                    okFun: () {
                                                      clients.deleteClient(
                                                          e[index].id);
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
                          ],
                        ),
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
