import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';

import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
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
                        Text(
                          'جودة المياه',
                          style: MainTheme.headingTextStyle,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                              hint: 'معدل ph',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            const CustomTextField(
                              hint: 'درجة حرارة المياه',
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            CustomTextField(
                              hint: 'اكسجين',
                            ),
                            CustomTextField(
                              hint: 'الملوحه',
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const CustomTextField(
                          hint: 'امونيات كلية',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBtn(
                          text: '0.0 = امونيات السامه',
                          color: Colors.blue[400],
                          heigh: 30,
                          weigh: 150,
                          txtColor: Colors.white,
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "عينه الاسماك",
                          style: MainTheme.headingTextStyle,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            CustomTextField(
                              hint: 'اعداد السمك',
                            ),
                            CustomTextField(
                              hint: 'الوزن الكلي ',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBtn(
                          text: '0.0 = متوسط الوزن',
                          color: Colors.blue[400],
                          heigh: 30,
                          weigh: 150,
                          txtColor: Colors.white,
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomTextField(
                          hint: 'عدد السمك النافق',
                        ),
                        CustomBtn(
                          text: '0.0 = اجمالي الوزن',
                          color: Colors.blue[400],
                          heigh: 30,
                          weigh: 150,
                          txtColor: Colors.white,
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomTextField(
                          hint: 'اجمالي العلف',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBtn(
                          text: '0.0 = معدل التحويل',
                          color: Colors.blue[400],
                          heigh: 30,
                          weigh: 150,
                          txtColor: Colors.white,
                          onTap: () {},
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
                        CustomTextButton(title: 'حفظ', function: () {})
                      ],
                    ),
                  ),
                ],
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
