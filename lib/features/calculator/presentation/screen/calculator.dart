import 'dart:math';

import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_headear_title.dart';

import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/calculator/presentation/widgets.dart/alert_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class Calculator extends HookConsumerWidget {
  final Client client;
  Calculator({Key? key, required this.client}) : super(key: key);
  num tempreatureOfWater = 0.0,
      ph = 0.0,
      s = 0.0,
      oxygen = 0.0,
      totalAmmonia = 0.0,
      molalIconicStrength = 0.0,
      pka = 0.0,
      theUnIonizedAmmonia = 0.0,
      totalWeightFishes = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _qualityWater = GlobalKey<FormState>();
  int totalFishes = 0, dieFishes = 0;
  bool warningPh = false,
      warningS = false,
      warningTotalAmmonia = false,
      warningOxygen = false,
      warningTempreatureOfWater = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<num> nH3 = useState<num>(0.0);
    final ValueNotifier<num> averageWeight = useState<num>(0.0);
    final ValueNotifier<num> totalWeight = useState<num>(0.0);
    final ValueNotifier<num> conversionRate = useState<num>(0.0);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
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
                            Form(
                              key: _qualityWater,
                              child: ListView(
                                primary: false,
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomTextField(
                                        hint: 'معدل ph',
                                        numbersOnly: true,
                                        onChange: (v) {
                                          try {
                                            ph = num.parse(v);
                                          } on FormatException {
                                            debugPrint('Format error!');
                                          }
                                        },
                                        calculator: true,
                                        type: TextInputType.number,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        maxLength: 5,
                                        minRange: 1,
                                        maxRange: 14,
                                        paste: false,
                                        validator: (value) {
                                          try {
                                            if (value!.isEmpty) {
                                              warningPh = false;
                                              return 'لا يجب ترك الحقل فارغ';
                                            } else if (1 <=
                                                    num.parse(value.trim()) &&
                                                num.parse(value.trim()) <=
                                                    6.4) {
                                              warningPh = false;
                                              return 'منخفضه جدا';
                                            } else if (9 <=
                                                    num.parse(value.trim()) &&
                                                num.tryParse(value.trim())! <=
                                                    14) {
                                              warningPh = false;
                                              return 'مرتفعه نسبيا';
                                            } else {
                                              warningPh = true;
                                            }
                                          } on FormatException {
                                            debugPrint('Format error!');
                                          }
                                        },
                                      ),
                                      CustomTextField(
                                        hint: 'درجة حرارة المياه',
                                        numbersOnly: true,
                                        type: TextInputType.number,
                                        calculator: true,
                                        onChange: (v) {
                                          try {
                                            tempreatureOfWater =
                                                double.parse(v);
                                          } on FormatException {
                                            debugPrint('Format error!');
                                          }
                                        },
                                        minRange: 1,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        maxRange: 99,
                                        maxLength: 5,
                                        paste: false,
                                        validator: (value) {
                                          try {
                                            if (value!.isEmpty) {
                                              warningTempreatureOfWater = false;
                                              return 'لا يجب ترك الحقل فارغ';
                                            } else if (0 <=
                                                    num.parse(value.trim()) &&
                                                num.tryParse(value.trim())! <=
                                                    17) {
                                              warningTempreatureOfWater = false;
                                              return 'منخفضه جدا';
                                            } else if (30 <=
                                                    num.parse(value.trim()) &&
                                                num.tryParse(value.trim())! <=
                                                    32) {
                                              warningTempreatureOfWater = false;
                                              return 'مرتفعه نسبيا';
                                            } else if (33 <=
                                                    num.parse(value.trim()) &&
                                                num.tryParse(value.trim())! <=
                                                    99) {
                                              warningTempreatureOfWater = false;
                                              return 'مرتفعه جدا';
                                            } else {
                                              warningTempreatureOfWater = true;
                                            }
                                          } on FormatException {
                                            debugPrint('Format error!');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomTextField(
                                        hint: 'اكسجين',
                                        numbersOnly: true,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onChange: (v) {
                                          try {
                                            oxygen = num.parse(v);
                                          } on FormatException {
                                            debugPrint('Format error!');
                                          }
                                        },
                                        calculator: true,
                                        type: TextInputType.number,
                                        maxLength: 5,
                                        minRange: 0,
                                        maxRange: 99,
                                        paste: false,
                                        validator: (value) {
                                          try {
                                            if (value!.isEmpty) {
                                              warningOxygen = false;
                                              return 'لا يجب ترك الحقل فارغ';
                                            } else if (0 <=
                                                    num.parse(value.trim()) &&
                                                num.parse(value.trim()) <= 1) {
                                              warningOxygen = false;
                                              return 'منخفضه جدا';
                                            } else {
                                              warningOxygen = true;
                                            }
                                          } on FormatException {
                                            debugPrint('Format error!');
                                          }
                                        },
                                      ),
                                      CustomTextField(
                                        hint: 'الملوحه',
                                        numbersOnly: true,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onChange: (v) {
                                          try {
                                            s = num.parse(v);
                                          } on FormatException {
                                            debugPrint('Format error!');
                                          }
                                        },
                                        calculator: true,
                                        type: TextInputType.number,
                                        maxLength: 5,
                                        minRange: 0,
                                        maxRange: 80,
                                        paste: false,
                                        validator: (value) {
                                          try {
                                            if (value!.isEmpty) {
                                              warningS = false;
                                              return 'لا يجب ترك الحقل فارغ';
                                            } else if (0 <=
                                                    num.parse(value.trim()) &&
                                                num.parse(value.trim()) <= 1) {
                                              warningS = false;
                                              return 'منخفضه جدا';
                                            } else {
                                              warningS = true;
                                            }
                                          } on FormatException {
                                            debugPrint('Format error!');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Center(
                                    child: CustomTextField(
                                      hint: 'امونيات كلية',
                                      onChange: (v) {
                                        try {
                                          totalAmmonia = num.parse(v);
                                        } on FormatException {
                                          debugPrint('Format error!');
                                        }
                                      },
                                      numbersOnly: true,
                                      calculator: true,
                                      type: TextInputType.number,
                                      maxLength: 8,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      minRange: 0,
                                      maxRange: 12,
                                      paste: false,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          warningTotalAmmonia = false;
                                          return 'لا يجب ترك الحقل فارغ';
                                        } else {
                                          warningTotalAmmonia = true;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomBtn(
                                        text: nH3.value == 0.0
                                            ? '0.0 = امونيات السامه'
                                            : nH3.value.toStringAsFixed(4) +
                                                ' = امونيات السامه',
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      CustomTextButton(
                                          width: SizeConfig.screenWidth * 0.1,
                                          hieght:
                                              SizeConfig.screenHeight * 0.05,
                                          radius: 15,
                                          title: ' = ',
                                          function: () async {
                                            if (s == 0.0 ||
                                                tempreatureOfWater == 0.0 ||
                                                totalAmmonia == 0.0 ||
                                                ph == 0.0) {
                                              _qualityWater.currentState!
                                                  .validate();
                                            } else {
                                              molalIconicStrength = 19.973 *
                                                  s /
                                                  (1000 - (1.2005109 * s));

                                              pka = 0.0901821 +
                                                  (2729.92 /
                                                      (tempreatureOfWater +
                                                          273.1)) +
                                                  ((0.1552 -
                                                          (0.0003142 *
                                                              tempreatureOfWater)) *
                                                      molalIconicStrength);
                                              theUnIonizedAmmonia =
                                                  1 / (1 + pow(10, pka - ph));

                                              nH3.value = totalAmmonia *
                                                  theUnIonizedAmmonia;

                                              debugPrint(
                                                  warningOxygen.toString());

                                              if (warningPh == false ||
                                                  warningS == false ||
                                                  warningOxygen == false ||
                                                  warningTotalAmmonia ==
                                                      false ||
                                                  warningTempreatureOfWater ==
                                                      false) {
                                                await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomDialog(
                                                          title:
                                                              'نصائح وارشادات',
                                                          widget: [
                                                            if (1 <= ph &&
                                                                ph <= 6.4)
                                                              const AlertCalCulator(
                                                                advice1:
                                                                    ' - تاكد من معدلات الاكسجين ',
                                                                advice2:
                                                                    ' - اضافه الجير الحي',
                                                                title:
                                                                    'درجة الحموضه منخفضه جدا',
                                                              ),
                                                            if (9 <= ph &&
                                                                ph <= 14)
                                                              const AlertCalCulator(
                                                                advice1:
                                                                    ' - تاكد من معدلات الامونيا',
                                                                advice2:
                                                                    ' - اضافه بعض الاحماض او سوبر فوسفات',
                                                                title:
                                                                    'درجة الحموضه مرتفعه جدا',
                                                              ),
                                                            if (0 <=
                                                                    tempreatureOfWater &&
                                                                tempreatureOfWater <=
                                                                    17)
                                                              const AlertCalCulator(
                                                                advice1:
                                                                    ' - اوقف التغذيه',
                                                                advice2:
                                                                    ' - استخدم سخانات المياه',
                                                                advice3:
                                                                    ' - استخدم الصوب الزراعيه ( ان امكن )',
                                                                title:
                                                                    'درجة حرارة المياه منخفضه جدا',
                                                              ),
                                                            if (30 <=
                                                                    tempreatureOfWater &&
                                                                tempreatureOfWater <=
                                                                    32)
                                                              const AlertCalCulator(
                                                                advice1:
                                                                    ' - قلل كمية العلف المستخدم',
                                                                advice2:
                                                                    ' - استخدم معدلات التهويه مثل البدالات ( ان وجد )',
                                                                title:
                                                                    'درجة حرارة المياه مرتفعه نسبيا',
                                                              ),
                                                            if (33 <=
                                                                    tempreatureOfWater &&
                                                                tempreatureOfWater <=
                                                                    99)
                                                              const AlertCalCulator(
                                                                advice1:
                                                                    ' -  اوقف التغذيه',
                                                                advice2:
                                                                    ' -  استخدم معدلات التهويه مثل البدالات (ان وجد )',
                                                                title:
                                                                    'درجة حرارة المياه مرتفعه جدا',
                                                              ),
                                                            if (0 <= oxygen &&
                                                                oxygen <= 1)
                                                              const AlertCalCulator(
                                                                advice1:
                                                                    ' - أوقف التغذيه ',
                                                                advice2:
                                                                    ' - استخدم اكسجين بودر للطوارئ',
                                                                advice3:
                                                                    ' - استخدم معدات التهويه مثل البدالات (ان وجدت )',
                                                                advice4:
                                                                    ' - تأكد من معدلات الحموضه والامونيا',
                                                                title:
                                                                    'درجة الاكسجين منخفضه جدا',
                                                              ),
                                                            if (nH3.value > 0.5)
                                                              const AlertCalCulator(
                                                                advice1:
                                                                    ' - اوقف التغذيه',
                                                                advice2:
                                                                    ' - اضافه بروبيوتك او يوكا',
                                                                advice3:
                                                                    '- تاكد من معدلات الحموضه و الاكسجين',
                                                                title:
                                                                    'درجة الامونيا مرتفعه جدا',
                                                              ),
                                                            Center(
                                                              child:
                                                                  CustomTextButton(
                                                                      title:
                                                                          'اغلاق',
                                                                      function:
                                                                          () {
                                                                        pop();
                                                                      }),
                                                            ),
                                                          ],
                                                        ));
                                              }
                                            }
                                          }),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                            const CustomHeaderTitle(title: "عينه الاسماك"),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  hint: 'اعداد السمك',
                                  onChange: (v) {
                                    try {
                                      totalFishes = int.parse(v);
                                    } on FormatException {
                                      debugPrint('Format error!');
                                    }
                                  },
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'لا يجب ترك الحقل فارغ';
                                    }
                                    return null;
                                  },
                                  numbersOnly: true,
                                  type: TextInputType.number,
                                  paste: false,
                                ),
                                CustomTextField(
                                  hint: 'الوزن الكلي ',
                                  onChange: (v) {
                                    try {
                                      totalWeightFishes = num.parse(v);
                                    } on FormatException {
                                      debugPrint('Format error!');
                                    }
                                  },
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'لا يجب ترك الحقل فارغ';
                                    }
                                    return null;
                                  },
                                  numbersOnly: true,
                                  calculator: true,
                                  type: TextInputType.number,
                                  maxLength: 5,
                                  paste: false,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomBtn(
                                  text: averageWeight.value == 0.0
                                      ? '0.0 = متوسط الوزن'
                                      : averageWeight.value.toStringAsFixed(2) +
                                          ' = متوسط الوزن',
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                CustomTextButton(
                                    width: SizeConfig.screenWidth * 0.1,
                                    hieght: SizeConfig.screenHeight * 0.05,
                                    radius: 15,
                                    title: ' = ',
                                    function: () {
                                      if (_formKey.currentState!.validate()) {
                                        averageWeight.value =
                                            totalWeightFishes / totalFishes;
                                      }
                                    }),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              hint: 'عدد السمك النافق',
                              onChange: (v) {
                                try {
                                  dieFishes = int.parse(v);
                                } on FormatException {
                                  debugPrint('Format error!');
                                }
                              },
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'لا يجب ترك الحقل فارغ';
                                }
                                return null;
                              },
                              type: TextInputType.number,
                              maxLength: 5,
                              numbersOnly: true,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomBtn(
                                    text: totalWeight.value == 0.0
                                        ? '0.0 = اجمالي الوزن'
                                        : '${totalWeight.value.toStringAsFixed(2)} = اجمالي الوزن}'),
                                const SizedBox(
                                  width: 20,
                                ),
                                CustomTextButton(
                                    width: SizeConfig.screenWidth * 0.1,
                                    hieght: SizeConfig.screenHeight * 0.05,
                                    radius: 15,
                                    title: ' = ',
                                    function: () {}),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                           CustomTextField(
                              hint: 'اجمالي العلف',
                               onChange: (v) {
                                try {
                                  dieFishes = int.parse(v);
                                } on FormatException {
                                  debugPrint('Format error!');
                                }
                              },
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'لا يجب ترك الحقل فارغ';
                                }
                                return null;
                              },
                              type: TextInputType.number,
                              maxLength: 5,
                              numbersOnly: true,

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomBtn(
                                    text: conversionRate.value == 0.0
                                        ? '0.0 = معدل التحويل'
                                        : '${conversionRate.value.toStringAsFixed(2)} = معدل التحويل}'),
                                const SizedBox(
                                  width: 20,
                                ),
                                CustomTextButton(
                                    width: SizeConfig.screenWidth * 0.1,
                                    hieght: SizeConfig.screenHeight * 0.05,
                                    radius: 15,
                                    title: ' = ',
                                    function: () {
                                      conversionRate.value =
                                          client.feed / totalWeightFishes;
                                    }),
                              ],
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
                            CustomTextButton(
                                title: 'حفظ',
                                function: () {
                                  if (_formKey.currentState!.validate()) {}
                                })
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
      ),
    );
  }
}
