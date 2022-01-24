import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';

import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/archieve/data/archieve_model.dart';
import 'package:aquameter/features/archieve/presentation/manager/archieve_notifier.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArcieveScreen extends HookConsumerWidget {
  ArcieveScreen({Key? key, required this.title}) : super(key: key);
  final String title;


  final List<String> dates = [
    'دورة 13/6/2021',
    'دورة 10/6/2021',
    'دورة 11/8/2022',
  ];
  final AutoDisposeFutureProvider<ArchieveModel> provider =
  FutureProvider.autoDispose<ArchieveModel>((ref) async {
    return await ref
        .watch(getArchiveNotifier.notifier)
        .getArchives(); // may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GetArchiveNotifier archive = ref.read(getArchiveNotifier.notifier);
    final ScrollController scrollController = ScrollController();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            title,
            style: MainTheme.headingTextStyle,
          ),
          centerTitle: true,
        ),
        body: ref.watch(provider).when(
          loading: () => const AppLoader(),
          error: (e, o) {
            debugPrint(e.toString());
            debugPrint(o.toString());
            return const Center(child: Text('error'));
          },
          data: (e) =>
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                    const Divider(
                      color: Colors.grey,
                    ),
                    itemCount: archive.archiveModel!.data!.length,
                    itemBuilder: (context, index) {
                      return ExpandablePanel(
                        collapsed: Container(),
                        header: Text(
                          archive.archiveModel!.data![index].name.toString(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        expanded: ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: archive.archiveModel!.data![index].periodsResultCount
                          ,
                          itemBuilder: (BuildContext context, int i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CustomTextButton(
                                    title: "دورة  ${archive.archiveModel!.data![index]
                                        .periodsResult![i].mceeting.toString()
                                        .substring(0, 10)}",
                                    function: () {
                              showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                              title: 'نتيجة الحصاد',
                              widget: [
                              Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                              CustomTextField(
                              hint:
                              'اجمالي وزن السمك بالكيلو',
                              width: SizeConfig.screenWidth *
                              0.3,
                              enabled: false,
                              ),
                              CustomTextField(
                              hint: 'اعداد السمك',
                              width: SizeConfig.screenWidth *
                              0.3,
                              enabled: false,
                              ),
                              ],
                              ),
                              const Center(
                              child: CustomBtn(
                              text: '0.0 = متوسط الوزن',
                              ),
                              ),
                              const SizedBox(
                              height: 20,
                              ),
                              const Center(
                              child: CustomTextField(
                              hint: 'اجمالي وزن العلف بالكيلو',
                              enabled: false,
                              ),
                              ),
                              const Center(
                              child: CustomBtn(
                              text: '0.0 = معدل النحويل',
                              ),
                              ),
                              const SizedBox(
                              width: 20,
                              ),
                              ],
                              ),
                              );
                              },
                              ),
                            ),);
                          },
                        ),
                      );
                    },
                  )),
        ),
      ),
    );
  }
}
