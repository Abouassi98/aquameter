import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';

import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';

import 'package:aquameter/core/utils/widgets/custom_headear_title.dart';

import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/features/profileClient/data/meeting_all_model..dart';

import 'package:flutter/material.dart';

class ShowCalculator extends StatelessWidget {
  final MeetingResult meetingResult;
  const ShowCalculator({Key? key, required this.meetingResult})
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
                                    hint: meetingResult.ph.toString(),
                                    enabled: false,
                                  ),
                                  CustomTextField(
                                    hint: meetingResult.temperature.toString(),
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
                                    hint: meetingResult.oxygen.toString(),
                                    enabled: false,
                                  ),
                                  CustomTextField(
                                    hint: meetingResult.salinity.toString(),
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
                                  hint: meetingResult.ammonia.toString(),
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: CustomBtn(
                                  text:
                                      '${meetingResult.toxicAmmonia} = امونيات السامه',
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
                                hint: meetingResult.totalNumber.toString(),
                                enabled: false,
                              ),
                              CustomTextField(
                                hint: meetingResult.totalWeight.toString(),
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
                                  '${meetingResult.averageWeight} = متوسط الوزن',
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
                            hint: meetingResult.deadFish.toString(),
                            enabled: false,
                          ),
                          Center(
                            child: CustomBtn(
                                text:
                                    '${meetingResult.totalWeight} = اجمالي الوزن'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'اجمالي العلف',
                            style: MainTheme.hintTextStyle,
                          ),
                          CustomTextField(
                            hint: meetingResult.feed.toString(),
                            enabled: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CustomBtn(
                                text:
                                    '${meetingResult.conversionRate} = معدل التحويل'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            width: SizeConfig.screenWidth * 0.7,
                            maxLines: 5,
                            hint: meetingResult.notes,
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
