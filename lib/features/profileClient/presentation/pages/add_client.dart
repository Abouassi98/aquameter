import 'dart:developer';

import 'package:aquameter/core/GlobalApi/AreaAndCities/Data/cities_model/area_and_cities_model.dart';
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';

import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/convert_arabic_numbers_to_english_number.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';

import 'package:aquameter/core/utils/widgets/custom_header_title.dart';

import 'package:aquameter/features/CustomMap/presentation/pages/custom_map.dart';
import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';

import 'package:aquameter/features/profileClient/presentation/manager/meeting_all_notifier.dart';

import 'package:aquameter/features/profileClient/presentation/widgets/total_fishes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/themes/themes.dart';
import '../../../CustomMap/presentation/manager/map_notifier.dart';

// ignore: must_be_immutable
class AddClient extends HookConsumerWidget {
  AddClient({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> listofMeasuer = [
    {'name': 'فدان', 'id': 1},
    {'name': 'م2', 'id': 2},
  ];

  final List<String> acceptedNumbers = [
    '012',
    '011',
    '015',
    '010',
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String phone = '', name = '', landSizeType = '', company = '', feed = '';
  num landSize = 0, targetWeight = 0, startingWeight = 0;
  int governorateId = 0, areaId = 0;
  List<int> totalFishes = [], typeFishes = [];
  int totalFishes1 = 0, typeFishes1 = 0;
  int? totalFishes2, totalFishes3, typeFishes2, typeFishes3;

  List<TotalFishesItem> totalFishesItem = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MeetingAllNotifier meetingAll = ref.read(meetingAllNotifier.notifier);
    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    final AddClientNotifier addClient = ref.read(
      addClientNotifier.notifier,
    );
    final map = ref.read(
      mapNotifier.notifier,
    );
      final address =
                                                  ref.watch(mapAddress);
    ValueNotifier<List<Cities>> listOfCities = useState<List<Cities>>([]);
    ValueNotifier<bool> newCity = useState<bool>(false);
    // ValueNotifier<bool> showSecondField = useState<bool>(false);
    // ValueNotifier<bool> showThirdField = useState<bool>(false);
    List<int> totalFishes = [], typeFishes = [];
    return SafeArea(
        child: Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              kAppLogo,
                              height: SizeConfig.screenHeight * 0.1,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 15),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  const CustomHeaderTitle(
                                      title: "إضافة عميل جديد"),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                    width: SizeConfig.screenWidth * 0.7,
                                    icon: Icons.person,
                                    hint: "اسم العميل",
                                    type: TextInputType.text,
                                    onChange: (v) {
                                      name = v;
                                    },
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'لا يجب ترك الحقل فارغ';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    showCounterTxt: true,
                                    hint: 'رقم الموبايل',
                                    icon: Icons.phone,
                                    type: TextInputType.phone,
                                    numbersOnly: true,
                                    width: SizeConfig.screenWidth * 0.7,
                                    maxLength: 11,
                                    validator: (v) {
                                      bool phoneNumberAccepted = false;
                                      if (v!.length < 10) {
                                        return 'رقم هاتف قصير';
                                      }
                                      for (String char in acceptedNumbers) {
                                        phoneNumberAccepted =
                                            v.startsWith(char);
                                        if (phoneNumberAccepted) {
                                          break;
                                        }
                                      }
                                      if (phoneNumberAccepted == false) {
                                        return 'رقم هاتف غير صالح';
                                      }
                                      log(
                                        phoneNumberAccepted.toString(),
                                      );
                                      return null;
                                    },
                                    onChange: (v) {
                                      phone = convertToEnglishNumbers(v.trim());
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomBottomSheet(
                                        name: 'المحافظه',
                                        list: areaAndCites
                                            .governorateModel!.data!,
                                        onChange: (v) async {
                                          areaId = 0;
                                          await areaAndCites.getCities(
                                              cityId: v);
                                          listOfCities.value =
                                              areaAndCites.areasModel!.data!;
                                          governorateId = v;
                                          newCity.value = true;
                                        },
                                      ),
                                      CustomBottomSheet(
                                        name: 'المدينه',
                                        list: listOfCities.value,
                                        newCity: newCity.value,
                                        onChange: (v) {
                                          areaId = v;
                                          newCity.value = false;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      map.initialLat = null;
                                      map.initialLong = null;
                                      push(CustomMap());
                                    },
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black38),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: SizeConfig.screenWidth * 0.5,
                                            child:  Text(
                                                  address ??
                                                      'حرك المؤشر ليتم اختيار العنوان المناسب لك',
                                                  style: MainTheme.hintTextStyle
                                                      .copyWith(
                                                          color: Colors.black),
                                                  maxLines: null
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 12,
                                              child: const Icon(
                                                Icons.location_on,
                                                size: 17,
                                                color: Colors.white,
                                              ),
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const CustomHeaderTitle(
                                      title: 'بيانات المزرعه'),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.9,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: SizeConfig.screenHeight *
                                                      0.04),
                                              child: CustomTextField(
                                                numbersOnly: true,
                                                calculator: true,
                                                paste: false,
                                                type: TextInputType.phone,
                                                validator: (v) {
                                                  if (v!.isEmpty) {
                                                    return 'لا يجب ترك الحقل فارغ';
                                                  }
                                                  return null;
                                                },
                                                hint: 'مساحة الأرض',
                                                onChange: (v) {
                                                  try {
                                                    landSize = num.parse(v);
                                                  } on FormatException {
                                                    debugPrint('Format error!');
                                                  }
                                                },
                                              ),
                                            ),
                                            CustomBottomSheet(
                                              staticList: true,
                                              name: 'فدان/ م',
                                              list: listofMeasuer,
                                              onChange: (v) {
                                                landSizeType = v;
                                                debugPrint(v);
                                              },
                                            ),
                                          ],
                                        ),
                                        TotalFishesItem(
                                          list: ref
                                              .read(
                                                fishTypesNotifier.notifier,
                                              )
                                              .fishTypesModel!
                                              .data!,
                                          onTotalFishesChange: (v) {
                                            totalFishes1 = v;
                                          },
                                          onTypeFishesChange: (v) {
                                            typeFishes1 = v;
                                          },
                                        ),
                                        // if (showSecondField.value == true)
                                        //   TotalFishesItem(
                                        //     list: ref
                                        //         .read(
                                        //           fishTypesNotifier.notifier,
                                        //         )
                                        //         .fishTypesModel!
                                        //         .data!,
                                        //     onDelete: () {
                                        //       showSecondField.value = false;
                                        //       totalFishes2 = null;
                                        //       typeFishes2 = null;
                                        //     },
                                        //     onTotalFishesChange: (v) {
                                        //       totalFishes2 = v;
                                        //     },
                                        //     onTypeFishesChange: (v) {
                                        //       typeFishes2 = v;
                                        //     },
                                        //   ),
                                        // if (showThirdField.value == true)
                                        //   TotalFishesItem(
                                        //     list: ref
                                        //         .read(
                                        //           fishTypesNotifier.notifier,
                                        //         )
                                        //         .fishTypesModel!
                                        //         .data!,
                                        //     onDelete: () {
                                        //       showThirdField.value = false;
                                        //       totalFishes3 = null;
                                        //       typeFishes3 = null;
                                        //     },
                                        //     onTotalFishesChange: (v) {
                                        //       totalFishes3 = v;
                                        //     },
                                        //     onTypeFishesChange: (v) {
                                        //       typeFishes3 = v;
                                        //     },
                                        //   ),
                                      ],
                                    ),
                                  ),
                                  // if (showThirdField.value == false ||
                                  //     showSecondField.value == false)
                                  //   Container(
                                  //     alignment: Alignment.centerRight,
                                  //     child: TextButton(
                                  //       onPressed: () {
                                  //         if (showSecondField.value == false) {
                                  //           showSecondField.value = true;
                                  //         } else if (showSecondField.value ==
                                  //                 true &&
                                  //             showThirdField.value == false) {
                                  //           showThirdField.value = true;
                                  //         }
                                  //       },
                                  //       child:
                                  //           const Text('إضافة عدد من نوع آخر '),
                                  //     ),
                                  //   ),
                                  // const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                                SizeConfig.screenHeight * 0.04),
                                        child: CustomTextField(
                                          hint: 'نوع العلف',
                                          onChange: (v) {
                                            feed = v;
                                          },
                                          validator: (v) {
                                            if (v!.isEmpty) {
                                              return 'لا يجب ترك الحقل فارغ';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                                SizeConfig.screenHeight * 0.04),
                                        child: CustomTextField(
                                          hint: 'اسم الشركه',
                                          onChange: (v) {
                                            company = v;
                                          },
                                          validator: (v) {
                                            if (v!.isEmpty) {
                                              return 'لا يجب ترك الحقل فارغ';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    calculator: true,
                                    paste: false,
                                    type: TextInputType.number,
                                    numbersOnly: true,
                                    hint: 'وزن السمكة الابتدائى بالجرام',
                                    onChange: (v) {
                                      try {
                                        startingWeight = num.parse(v);
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
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    numbersOnly: true,
                                    calculator: true,
                                    paste: false,
                                    type: TextInputType.number,
                                    hint: 'وزن السمكة المستهدف بالجرام',
                                    onChange: (v) {
                                      try {
                                        targetWeight = num.parse(v);
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
                                  ),
                                ],
                              ),
                            ),
                            CustomTextButton(
                              title: "حفظ",
                              function: () {
                                if (landSizeType == '') {
                                  HelperFunctions.errorBar(context,
                                      message: 'يجب عليك تحديد نوع الارض اولا');
                                } else if (areaId == 0) {
                                  HelperFunctions.errorBar(context,
                                      message: 'يجب عليك تحديد المدينه اولا');
                                } else if (typeFishes1 == 0) {
                                  HelperFunctions.errorBar(context,
                                      message: 'يجب عليك تحديد نوع السمك اولا');
                                } else if (addClient.address == null) {
                                  HelperFunctions.errorBar(context,
                                      message:
                                          'يجب عليك تحديد الموقع للعمل اولا');
                                } else if (_formKey.currentState!.validate()) {
                                  totalFishes.add(totalFishes1);
                                  typeFishes.add(typeFishes1);
                                  if (totalFishes2 != null) {
                                    totalFishes.add(totalFishes2!);
                                    typeFishes.add(typeFishes2!);
                                  }
                                  if (totalFishes3 != null) {
                                    totalFishes.add(totalFishes3!);
                                    typeFishes.add(typeFishes3!);
                                  }
                                  addClient.totalFishes = totalFishes;
                                  addClient.typeFishes = typeFishes;
                                  meetingAll.isInit = false;
                                  addClient.addClient(
                                    context: context,
                                    phone: phone,
                                    name: name,
                                    governorateId: governorateId,
                                    areaId: areaId,
                                    landSize: landSize,
                                    startingWeight: startingWeight,
                                    targetWeight: targetWeight,
                                    landSizeType: landSizeType,
                                    company: company,
                                    feed: feed,
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
                      onPressed: () {
                        pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
