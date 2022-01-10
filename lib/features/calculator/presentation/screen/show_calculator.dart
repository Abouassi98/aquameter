import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';

import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';

import 'package:aquameter/core/utils/widgets/custom_headear_title.dart';

import 'package:aquameter/core/utils/widgets/custom_text_field.dart';

import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';

import 'package:flutter/material.dart';

class ShowCalculator extends StatelessWidget {
  final Client client;
  const ShowCalculator({Key? key, required this.client}) : super(key: key);

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
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  CustomTextField(
                                    hint: 'معدل ph',
                                    enabled: false,
                                  ),
                                  CustomTextField(
                                    hint: 'درجة حرارة المياه',
                                    enabled: false,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  CustomTextField(
                                    hint: 'اكسجين',
                                    enabled: false,
                                  ),
                                  CustomTextField(
                                    hint: 'الملوحه',
                                    enabled: false,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Center(
                                child: CustomTextField(
                                  hint: 'امونيات كلية',
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Center(
                                child: CustomBtn(
                                  text: '0.0 = امونيات السامه',
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              CustomTextField(
                                hint: 'اعداد السمك',
                                enabled: false,
                              ),
                              CustomTextField(
                                hint: 'الوزن الكلي بالجرام',
                                enabled: false,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: CustomBtn(
                              text: '0.0 = متوسط الوزن',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const CustomTextField(
                            hint: 'عدد السمك النافق',
                            enabled: false,
                          ),
                          const Center(
                            child: CustomBtn(text: '0.0 = اجمالي الوزن'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const CustomTextField(
                            hint: 'اجمالي العلف بالكجم',
                            enabled: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: CustomBtn(text: '0.0 = معدل التحويل'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            width: SizeConfig.screenWidth * 0.7,
                            maxLines: 5,
                            hint: 'ملاحظاتك',
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
