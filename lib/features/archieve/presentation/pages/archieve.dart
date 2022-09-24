import 'package:aquameter/core/themes/themes.dart';

import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';

import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/archieve/data/archieve_model.dart';
import 'package:aquameter/features/archieve/presentation/manager/archieve_notifier.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/utils/services/localization_service.dart';
import '../../../../core/utils/sizes.dart';
import '../../../../core/utils/widgets/app_loader.dart';


class ArcieveScreen extends ConsumerWidget {
  ArcieveScreen({
    Key? key,
  }) : super(key: key);

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
            tr(context).archieve,
            style: MainTheme.headingTextStyle,
          ),
          centerTitle: true,
        ),
        body: ref.watch(provider).when(
              loading: () =>const AppLoader(),
              error: (e, o) {
                debugPrint(e.toString());
                debugPrint(o.toString());
                return const Center(child: Text('error'));
              },
              data: (e) => archive.archiveModel!.data!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(25),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                        ),
                        itemCount: archive.archiveModel!.data!.length,
                        itemBuilder: (context, index) {
                          return ExpandablePanel(
                            collapsed: const SizedBox(),
                            header: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                archive.archiveModel!.data![index].name
                                    .toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            expanded: ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount: archive.archiveModel!.data![index]
                                  .periodsResultCount,
                              itemBuilder: (BuildContext context, int i) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CustomTextButton(
                                      title:
                                          "${tr(context).period}  ${archive.archiveModel!.data![index].periodsResult![i].mceeting.toString().substring(0, 10)}",
                                      function: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => CustomDialog(
                                            title: tr(context).periodResult,
                                            widget: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        tr(context).totalWeight,
                                                        style: MainTheme
                                                            .hintTextStyle,
                                                      ),
                                                      Text(
                                                        tr(context).fishNumber,
                                                        style: MainTheme
                                                            .hintTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      CustomTextField(
                                                        initialValue: archive
                                                            .archiveModel!
                                                            .data![index]
                                                            .periodsResult![i]
                                                            .totalWieght
                                                            .toString(),
                                                        width: Sizes
                                                                .fullScreenWidth(
                                                                    context) *
                                                            0.3,
                                                        enabled: false,
                                                      ),
                                                      CustomTextField(
                                                        initialValue: (archive
                                                            .archiveModel!
                                                            .data![index]
                                                            .periodsResult![i]
                                                            .totalNumber
                                                            .toString()),
                                                        width: Sizes
                                                                .fullScreenWidth(
                                                                    context) *
                                                            0.3,
                                                        enabled: false,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Center(
                                                child: CustomText(
                                                  text:
                                                      '${archive.archiveModel!.data![index].periodsResult![i].avrageWieght ?? '0'}'
                                                      ' = ${tr(context).avrageWieght}',
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      tr(context).avrageFooder,
                                                      style: MainTheme
                                                          .hintTextStyle,
                                                    ),
                                                    CustomTextField(
                                                      initialValue: archive
                                                                  .archiveModel!
                                                                  .data![index]
                                                                  .periodsResult![
                                                                      i]
                                                                  .avrageFooder !=
                                                              null
                                                          ? archive
                                                              .archiveModel!
                                                              .data![index]
                                                              .periodsResult![i]
                                                              .avrageFooder
                                                              .toString()
                                                          : '',
                                                      enabled: false,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Center(
                                                child: CustomText(
                                                  text: archive
                                                              .archiveModel!
                                                              .data![index]
                                                              .periodsResult![i]
                                                              .conversionRate ==
                                                          null
                                                      ? 'error'
                                                      : '${archive.archiveModel!.data![index].periodsResult![i].conversionRate!.toStringAsFixed(2)}'
                                                          ' = ${tr(context).conversionRate}',
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
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'لا يوجد عملاء',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Lottie.asset(
                          'assets/images/noData.json',
                          repeat: false,
                        ),
                      ],
                    ),
            ),
      ),
    );
  }
}
