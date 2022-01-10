import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';

import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ArcieveScreen extends StatelessWidget {
  ArcieveScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  final List<String> names = [
    'الحاج محمد احمد سليم',
    'الحاج مصطفي محمد احمد',
  ];

  final List<String> dates = [
    'دورة 13/6/2021',
    'دورة 10/6/2021',
    'دورة 11/8/2022',
  ];

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ExpandablePanel(
                  collapsed: Container(),
                  header: Text(
                    names[index],
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  expanded: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dates.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomTextButton(
                            title: dates[i],
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
                                          hint: 'اجمالي وزن السمك بالكيلو',
                                          width: SizeConfig.screenWidth * 0.3,
                                          enabled: false,
                                        ),
                                        CustomTextField(
                                          hint: 'اعداد السمك',
                                          width: SizeConfig.screenWidth * 0.3,
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
                        ),
                      );
                    },
                  ),
                );
              },
            )),
      ),
    );
  }
}
