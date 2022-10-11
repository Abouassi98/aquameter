import 'dart:math';
import 'package:aquameter/core/screens/popup_page.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/widgets/custom_btn.dart';
import 'package:aquameter/core/utils/widgets/custom_dialog.dart';
import 'package:aquameter/core/utils/widgets/custom_header_title.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/calculator/presentation/manager/create_meeting_result_notifier.dart';
import 'package:aquameter/features/calculator/presentation/widgets/alert_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/services/localization_service.dart';
import '../../../../core/utils/sizes.dart';
import '../../../Home/Data/clients_model/client_model.dart';

num tempreatureOfWater = 0.0,
    ph = 0.0,
    s = 0.0,
    feed = 0.0,
    oxygen = 0.0,
    totalAmmonia = 0.0,
    molalIconicStrength = 0.0,
    pka = 0.0,
    theUnIonizedAmmonia = 0.0,
    totalWeightFishes = 0.0;

int totalFishes = 0, dieFishes = 0, totalPreviousFishes = 0;
bool warningPh = false,
    warningS = false,
    warningTotalAmmonia = false,
    warningOxygen = false,
    warningTempreatureOfWater = false;

String notes = '';

final qualityWaterKey = useMemoized(() => GlobalKey<FormState>());
final averageWeightKey = useMemoized(() => GlobalKey<FormState>());
final dieFishesKey = useMemoized(() => GlobalKey<FormState>());
final conversionRateKey = useMemoized(() => GlobalKey<FormState>());

class Calculator extends HookConsumerWidget {
  final int meetingId;
  final num totalFeed;
  final Client client;
  final DateTime dateTime;

  Calculator(
      {Key? key,
      required this.totalFeed,
      required this.meetingId,
      required this.dateTime,
      required this.client})
      : super(key: key);

  final StateProvider<num> nH3Provider = StateProvider<num>((ref) => 0.0);

  final StateProvider<num> averageWeightProvider =
      StateProvider<num>((ref) => 0.0);
  final StateProvider<num> totalWeightProvider =
      StateProvider<num>((ref) => 0.0);
  final StateProvider<num> conversionRateProvider =
      StateProvider<num>((ref) => 0.0);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CreateMeetingResultNotifier createMeetingResult = ref.read(
      createMeetingResultNotifier.notifier,
    );
    final num nH3 = ref.watch(nH3Provider);
    final num averageWeight = ref.watch(averageWeightProvider);
    final num totalWeight = ref.watch(totalWeightProvider);
    final num conversionRate = ref.watch(conversionRateProvider);

    for (int i = 0; i < client.fish!.length; i++) {
      totalPreviousFishes += int.parse(client.fish![i].number!);
    }

    return PopUpPage(
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
                      height: Sizes.fullScreenHeight(context) * 0.1,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 15),
                    CustomHeaderTitle(
                      title: dateTime.toString().substring(0, 10),
                      color: Colors.blue[400],
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 15),
                          CustomHeaderTitle(
                            title: tr(context).water_quality,
                          ),
                          const SizedBox(height: 15),
                          Form(
                            key: qualityWaterKey,
                            child: ListView(
                              primary: false,
                              shrinkWrap: true,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomTextField(
                                      hint: tr(context).ph_average,
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
                                            return tr(context)
                                                .the_field_should_not_be_left_blank;
                                          } else if (1 <=
                                                  num.parse(value.trim()) &&
                                              num.parse(value.trim()) <= 6.4) {
                                            warningPh = false;
                                            return tr(context).very_low;
                                          } else if (9 <=
                                                  num.parse(value.trim()) &&
                                              num.tryParse(value.trim())! <=
                                                  14) {
                                            warningPh = false;
                                            return tr(context).relatively_high;
                                          } else {
                                            warningPh = true;
                                          }
                                        } on FormatException {
                                          debugPrint('Format error!');
                                        }
                                        return null;
                                      },
                                    ),
                                    CustomTextField(
                                      hint: tr(context).water_temperature,
                                      numbersOnly: true,
                                      type: TextInputType.number,
                                      calculator: true,
                                      onChange: (v) {
                                        try {
                                          tempreatureOfWater = double.parse(v);
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
                                            return tr(context)
                                                .the_field_should_not_be_left_blank;
                                          } else if (0 <=
                                                  num.parse(value.trim()) &&
                                              num.tryParse(value.trim())! <=
                                                  17) {
                                            warningTempreatureOfWater = false;
                                            return tr(context).very_low;
                                          } else if (30 <=
                                                  num.parse(value.trim()) &&
                                              num.tryParse(value.trim())! <=
                                                  32) {
                                            warningTempreatureOfWater = false;
                                            return tr(context).relatively_high;
                                          } else if (33 <=
                                                  num.parse(value.trim()) &&
                                              num.tryParse(value.trim())! <=
                                                  99) {
                                            warningTempreatureOfWater = false;
                                            return tr(context).very_high;
                                          } else {
                                            warningTempreatureOfWater = true;
                                          }
                                        } on FormatException {
                                          debugPrint('Format error!');
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
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
                                        return null;
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
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
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
                                      return null;
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: nH3 == 0.0
                                          ? '0.0 = امونيات السامه'
                                          : '${nH3.toStringAsFixed(4)} = امونيات السامه',
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    CustomTextButton(
                                        width: Sizes.roundedButtonMinWidth(
                                            context),
                                        hieght: Sizes.roundedButtonMinHeight(
                                            context),
                                        radius:
                                            Sizes.roundedButtonDefaultRadius(
                                                context),
                                        title: ' = ',
                                        function: () async {
                                          if (s == 0.0 ||
                                              tempreatureOfWater == 0.0 ||
                                              totalAmmonia == 0.0 ||
                                              ph == 0.0) {
                                            qualityWaterKey.currentState!
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

                                            ref.read(nH3Provider.state).state =
                                                totalAmmonia *
                                                    theUnIonizedAmmonia;

                                            debugPrint(
                                                warningOxygen.toString());

                                            if (warningPh == false ||
                                                warningS == false ||
                                                warningOxygen == false ||
                                                warningTotalAmmonia == false ||
                                                warningTempreatureOfWater ==
                                                    false) {
                                              await showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => CustomDialog(
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
                                                              if (nH3 > 0.5)
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
                                                                          NavigationService.goBack(
                                                                              context);
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
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          const CustomHeaderTitle(title: "عينه الاسماك"),
                          const SizedBox(height: 15),
                          Form(
                            key: averageWeightKey,
                            child: Row(
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
                                  hint: 'الوزن الكلي بالجرام',
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
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: averageWeight == 0.0
                                    ? '0.0 = متوسط الوزن'
                                    : '${averageWeight.toStringAsFixed(2)} = متوسط الوزن',
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomTextButton(
                                  width: Sizes.roundedButtonMinWidth(context),
                                  hieght: Sizes.roundedButtonMinHeight(context),
                                  radius:
                                      Sizes.roundedButtonDefaultRadius(context),
                                  title: ' = ',
                                  function: () {
                                    if (averageWeightKey.currentState!
                                        .validate()) {
                                      ref
                                              .read(averageWeightProvider.state)
                                              .state =
                                          totalWeightFishes / totalFishes;
                                    }
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(' عدد السمك الكلي= ${client.fish![0].number}'),
                          if (client.fish![0].number != '0')
                            Form(
                              key: dieFishesKey,
                              child: CustomTextField(
                                hint: 'عدد السمك النافق',
                                onChange: (v) {
                                  try {
                                    dieFishes = int.parse(v);
                                  } on FormatException {
                                    debugPrint('Format error!');
                                  }
                                },
                                minRange: 0,
                                calculator: false,
                                maxRange: int.parse(client.fish![0].number!),
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'لا يجب ترك الحقل فارغ';
                                  }
                                  return null;
                                },
                                type: TextInputType.number,
                                maxLength: 5,
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: totalWeight == 0.0
                                      ? '0.0 = اجمالي الوزن'
                                      : '${totalWeight.toStringAsFixed(2)} =  اجمالي الوزن'),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomTextButton(
                                  width: Sizes.roundedButtonMinWidth(context),
                                  hieght: Sizes.roundedButtonMinHeight(context),
                                  radius:
                                      Sizes.roundedButtonDefaultRadius(context),
                                  title: ' = ',
                                  function: () {
                                    if (averageWeight == 0.0) {
                                      HelperFunctions.errorBar(context,
                                          message:
                                              'يجب عليك اظهار ناتج متوسط الوزن الكلي للسمك بالكجم');
                                    } else if (dieFishesKey.currentState!
                                        .validate()) {
                                      ref
                                              .read(totalWeightProvider.state)
                                              .state =
                                          ((totalPreviousFishes - dieFishes) *
                                                  averageWeight) /
                                              1000;
                                    }
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              'اجمال العلف الكلي للزيارات السابقه = $totalFeed'),
                          Form(
                            key: conversionRateKey,
                            child: CustomTextField(
                              hint: 'اجمالي العلف بالكجم',
                              paste: false,
                              calculator: true,
                              onChange: (v) {
                                try {
                                  feed = num.parse(v);
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
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: conversionRate == 0.0
                                      ? '0.0 = معدل التحويل'
                                      : '${conversionRate.toStringAsFixed(2)} = معدل التحويل'),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomTextButton(
                                  width: Sizes.roundedButtonMinWidth(context),
                                  hieght: Sizes.roundedButtonMinHeight(context),
                                  radius:
                                      Sizes.roundedButtonDefaultRadius(context),
                                  title: ' = ',
                                  function: () {
                                    if (totalWeight == 0.0) {
                                      HelperFunctions.errorBar(context,
                                          message:
                                              'يجب عليك اظهار ناتج اجمالي الوزن الكلي للسمك بالكجم');
                                    } else if (conversionRateKey.currentState!
                                        .validate()) {
                                      ref
                                          .read(conversionRateProvider.state)
                                          .state = ((totalFeed +
                                              feed) /
                                          totalWeight);
                                    }
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            width: Sizes.fullScreenWidth(context) * 0.7,
                            maxLines: 5,
                            hint: 'ملاحظاتك',
                            onChange: (v) {
                              notes = v;
                            },
                            icon: Icons.note,
                          ),
                          CustomTextButton(
                              title: 'حفظ',
                              function: () {
                                createMeetingResult.createMeetingResult(
                                  realDate: dateTime,
                                  context: context,
                                  meetId: meetingId,
                                  ammonia: totalAmmonia,
                                  avrageWieght: averageWeight,
                                  conversionRate: conversionRate,
                                  deadFishes: dieFishes,
                                  feed: feed,
                                  ph: ph,
                                  notes: notes,
                                  oxygen: oxygen,
                                  salinity: s,
                                  totalFishes: totalFishes,
                                  temperature: tempreatureOfWater,
                                  totalWeight: totalWeight,
                                  toxicAmmonia: nH3,
                                );
                              }),
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
                icon: const Icon(Icons.arrow_back_ios),
              )
            ],
          ),
        ],
      ),
    );
  }
}
