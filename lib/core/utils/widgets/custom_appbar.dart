import 'package:aquameter/core/themes/screen_utility.dart';

import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/features/Home/Data/three_values_model.dart';
import 'package:aquameter/features/Home/presentation/manager/three_values_notifier.dart';

import 'package:aquameter/features/Home/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants.dart';

import '../size_config.dart';

class CustomAppBar extends HookConsumerWidget {
  final bool? search, back, drawer;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  CustomAppBar(
      {Key? key,
      this.search,
      this.onChanged,
      this.controller,
      this.back,
      this.drawer})
      : super(key: key);

  final AutoDisposeFutureProvider<ThreeValuesModel> provider =
      FutureProvider.autoDispose<ThreeValuesModel>((ref) async {
    return await ref
        .read(getThreeValuesNotifier.notifier)
        .getValues(); //; may cause `provider` to rebuild
  });

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
            height: SizeConfig.screenHeight * 0.04,
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
                    pop();
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
                  : Padding(
                      padding:
                          EdgeInsets.only(left: SizeConfig.screenWidth * .28),
                      child: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            push(SearchScreen(
                              viewProfile: true,
                            ));
                          }),
                    ),
              SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                  width: 100,
                  child: Image.asset(
                    kAppLogo,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
          if (search != true || back != true)
            ref.watch(provider).when(
                  loading: () => SpinKitFadingCircle(
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
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
                            const Text(
                              'معدل التحويل',
                              style: TextStyle(
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
                            const Text(
                              'الاسماك/طن',
                              style: TextStyle(
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
                            const Text(
                              'الاعلاف/طن',
                              style: TextStyle(
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
