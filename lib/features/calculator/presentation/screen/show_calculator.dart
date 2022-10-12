import 'package:aquameter/core/screens/popup_page.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_header_title.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/sizes.dart';
import '../../../../core/utils/widgets/custom_new_dialog.dart';
import '../../../profileClient/data/period_results_model.dart';
import '../manager/create_meeting_result_notifier.dart';

class ShowCalculator extends ConsumerWidget {
  final PeriodResults periodResults;
  ShowCalculator({Key? key, required this.periodResults}) : super(key: key);
  final CustomWarningDialog _dialog = CustomWarningDialog();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CreateMeetingResultNotifier removeMeetingResult = ref.read(
      createMeetingResultNotifier.notifier,
    );
    return PopUpPage(
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Image.asset(
                      kAppLogo,
                      height: Sizes.fullScreenHeight(context) * 0.1,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomHeaderTitle(title: 'جودة المياه'),
                              IconButton(
                                onPressed: () async {
                                  await _dialog.showOptionDialog(
                                      context: context,
                                      msg: 'هل ترغب بالحذف النهائي ؟',
                                      okFun: () async {
                                        removeMeetingResult.removeMeetingResult(
                                            meetingResultId: periodResults.id!);
                                      },
                                      okMsg: 'نعم',
                                      cancelMsg: 'لا',
                                      cancelFun: () {
                                        return;
                                      });
                                },
                                icon: const Icon(Icons.delete, size: 30),
                                color: Colors.red,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'معدل ph',
                                    style: MainTheme.hintTextStyle,
                                  ),
                                  Text(
                                    'درجة حرارة المياه',
                                    style: MainTheme.hintTextStyle,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextField(
                                    hint: periodResults.ph.toString(),
                                    enabled: false,
                                  ),
                                  CustomTextField(
                                    hint: periodResults.temperature.toString(),
                                    enabled: false,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'اكسجين',
                                    style: MainTheme.hintTextStyle,
                                  ),
                                  Text(
                                    'الملوحه',
                                    style: MainTheme.hintTextStyle,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextField(
                                    hint: periodResults.oxygen.toString(),
                                    enabled: false,
                                  ),
                                  CustomTextField(
                                    hint: periodResults.salinity.toString(),
                                    enabled: false,
                                  ),
                                ],
                              ),
                              Center(
                                child: Text(
                                  'امونيات كليه',
                                  style: MainTheme.hintTextStyle,
                                ),
                              ),
                              Center(
                                child: CustomTextField(
                                  hint: periodResults.ammonia.toString(),
                                  enabled: false,
                                ),
                              ),
                              Center(
                                child: CustomText(
                                  text:
                                      '${periodResults.toxicAmmonia} = امونيات السامه',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          const CustomHeaderTitle(title: "عينه الاسماك"),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'اعداد السمك',
                                style: MainTheme.hintTextStyle,
                              ),
                              Text(
                                'الوزن الكلي بالجرام',
                                style: MainTheme.hintTextStyle,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextField(
                                hint: periodResults.totalNumber.toString(),
                                enabled: false,
                              ),
                              CustomTextField(
                                hint: periodResults.totalWeight.toString(),
                                enabled: false,
                              ),
                            ],
                          ),
                          Center(
                            child: CustomText(
                              text:
                                  '${periodResults.averageWeight} = متوسط الوزن',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'عدد السمك النافق',
                            style: MainTheme.hintTextStyle,
                          ),
                          CustomTextField(
                            hint: periodResults.deadFish.toString(),
                            enabled: false,
                          ),
                          Center(
                            child: CustomText(
                                text:
                                    '${periodResults.totalWeight} = اجمالي الوزن'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'اجمالي العلف',
                            style: MainTheme.hintTextStyle,
                          ),
                          CustomTextField(
                            hint: periodResults.feed.toString(),
                            enabled: false,
                          ),
                          Center(
                            child: CustomText(
                                text:
                                    '${periodResults.conversionRate} = معدل التحويل'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            width: Sizes.fullScreenWidth(context) * 0.7,
                            maxLines: 5,
                            hint: periodResults.notes,
                            onChange: (v) {},
                            icon: Icons.note,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    NavigationService.goBack(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios))
            ],
          ),
        ],
      ),
    );
  }
}
