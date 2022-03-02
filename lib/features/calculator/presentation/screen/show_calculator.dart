import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';

import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';

import 'package:aquameter/core/utils/widgets/custom_header_title.dart';

import 'package:aquameter/core/utils/widgets/custom_text_field.dart';


import 'package:flutter/material.dart';

import '../../../profileClient/data/period_results_model.dart';

class ShowCalculator extends StatelessWidget {
  final PeriodResults periodResults;
  const ShowCalculator({Key? key, required this.periodResults})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: ListView(
        primary: false,
        shrinkWrap: true,
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
                      height: SizeConfig.screenHeight * 0.1,
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
                          const CustomHeaderTitle(title: 'جودة المياه'),
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
                              const SizedBox(height: 15),
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
                              const SizedBox(height: 15),
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
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: CustomBtn(
                                  text:
                                      '${periodResults.toxicAmmonia} = امونيات السامه',
                                ),
                              ),
                              const SizedBox(
                                height: 50,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CustomBtn(
                              text:
                                  '${periodResults.averageWeight} = متوسط الوزن',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'الوزن الكلي بالجرام',
                            style: MainTheme.hintTextStyle,
                          ),
                          CustomTextField(
                            hint: periodResults.deadFish.toString(),
                            enabled: false,
                          ),
                          Center(
                            child: CustomBtn(
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
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CustomBtn(
                                text:
                                    '${periodResults.conversionRate} = معدل التحويل'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            width: SizeConfig.screenWidth * 0.7,
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
                    pop();
                  },
                  icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
        ],
      ),
    );
  }
}
