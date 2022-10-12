import 'package:aquameter/core/themes/screen_utility.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/features/Home/Data/three_values_model.dart';
import 'package:aquameter/features/Home/presentation/manager/three_values_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../constants.dart';

import '../routing/navigation_service.dart';
import '../services/localization_service.dart';
import '../sizes.dart';

final AutoDisposeFutureProvider<ThreeValuesModel> provider =
    FutureProvider.autoDispose<ThreeValuesModel>((ref) async {
  return await ref
      .read(getThreeValuesNotifier.notifier)
      .getValues(); //; may cause `provider` to rebuild
});

class CustomAppBar extends ConsumerWidget {
  final bool? search, back, drawer;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const CustomAppBar(
      {Key? key,
      this.search,
      this.onChanged,
      this.controller,
      this.back,
      this.drawer})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GetThreeValuesNotifier threeValues = ref.read(
      getThreeValuesNotifier.notifier,
    );
    return Container(
      decoration: const BoxDecoration(
        color: MainStyle.primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: Sizes.fullScreenHeight(context) * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (drawer == true)
                InkWell(
                  child: const Icon(Icons.menu),
                  onTap: () => Scaffold.of(context).openDrawer(),
                ),
              if (back == true)
                InkWell(
                  child: const Icon(Icons.arrow_back_ios),
                  onTap: () {
                    NavigationService.goBack(context);
                  },
                ),
              search == true
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: CustomTextField(
                        controller: controller,
                        hint: 'بحث',
                        onChange: onChanged,
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                  height: Sizes.fullScreenHeight(context) * 0.09,
                  child: Image.asset(
                    kAppLogo,
                    fit: BoxFit.fill,
                  )),
            ],
          ),
          if (search != true || back != true)
            ref.watch(provider).when(
                  loading: () => const SizedBox(),
                  error: (e, o) {
                    debugPrint(e.toString());
                    debugPrint(o.toString());
                    return const Text('error');
                  },
                  data: (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              threeValues.threeValuesModel!.data!.conversionRate
                                  .toString(),
                              style: const TextStyle(
                                color: Color(0xff282759),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              tr(context).conversionRate,
                              style: const TextStyle(
                                color: Color(0xff282759),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              threeValues.threeValuesModel!.data!.fishWieght
                                  .toString(),
                              style: const TextStyle(
                                color: Color(0xff282759),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '${tr(context).fish}/${tr(context).ton}',
                              style: const TextStyle(
                                color: Color(0xff282759),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              threeValues.threeValuesModel!.data!.totalFeed
                                  .toString(),
                              style: const TextStyle(
                                color: Color(0xff282759),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '${tr(context).feed}/${tr(context).ton}',
                              style: const TextStyle(
                                color: Color(0xff282759),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
