import 'dart:developer';

import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/convert_arabic_numbers_to_english_number.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_country_code_picker.dart';
import 'package:aquameter/core/utils/widgets/custom_headear_title.dart';

import 'package:aquameter/core/utils/widgets/custom_map.dart';
import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/profile/presentation/manager/location_notifier.dart';
import 'package:aquameter/features/profile/presentation/pages/profile_screen.dart';
import 'package:aquameter/features/profile/presentation/widgets/total_fishes.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class AddClient extends HookConsumerWidget {
  AddClient({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> listofObject = [
    {'name': 'الغربيه', 'id': 1},
    {'name': 'المنوفية', 'id': 2},
    {'name': 'البحيرة', 'id': 3},
    {'name': 'الاسكندرية', 'id': 4},
    {'name': 'القاهرة', 'id': 5},
    {'name': 'الاسماعيلية', 'id': 6},
    {'name': 'أسيوط', 'id': 7},
    {'name': 'الاقصر', 'id': 8},
    {'name': 'بنى سويف', 'id': 9},
    {'name': 'بورسعيد', 'id': 10},
    {'name': 'دمياط', 'id': 11},
    {'name': 'سوهاج', 'id': 12},
  ];

  final List<Map<String, dynamic>> listofMeasuer = [
    {'name': 'فدان', 'id': 1},
    {'name': 'م2', 'id': 2},
  ];
  final List<Map<String, dynamic>> listofTypes = [
    {'name': 'بورى', 'id': 1},
    {'name': 'بلطى', 'id': 2},
    {'name': 'جمبرى', 'id': 3}
  ];
  final List<String> acceptedNumbers = [
    '012',
    '011',
    '015',
    '010',
  ];
  String phone = '', countryCode = '+20';
  List<TotalFishesItem> totalFishesItem = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocationProvider location = ref.watch(locationProvider.notifier);

    final ValueNotifier<List<TotalFishesItem>> listTotalFishesItem =
        useState<List<TotalFishesItem>>([
      TotalFishesItem(
        list: listofTypes,
      )
    ]);

    return SafeArea(
        child: Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
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
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
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
                                      phoneNumberAccepted = v.startsWith(char);
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
                                  },
                                  suffixIcon: CustomCountryCodePicker(
                                    onChange: (Country value) {
                                      countryCode = '+' '${value.phoneCode}';
                                      debugPrint(countryCode);
                                    },
                                  ),
                                  onChange: (v) {
                                    phone = convertToEnglishNumbers(v.trim());
                                    if (v.startsWith('0')) {
                                      phone = v.substring(1, v.length);
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomBottomSheet(
                                      name: 'المنطقه',
                                      list: listofObject,
                                    ),
                                    CustomBottomSheet(
                                      name: 'المحافظه',
                                      list: listofObject,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    push(const CustomMap(
                                        driverLat: 30.3, driverLong: 31.3));
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
                                        Text(location.address ?? 'العنوان'),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 12,
                                            child: const Icon(
                                              Icons.location_on,
                                              size: 17,
                                              color: Colors.white,
                                            ),
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text('بيانات المزرعه',
                                    style: MainTheme.headingTextStyle),
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
                                            child: const CustomTextField(
                                              hint: 'مساحة الأرض',
                                            ),
                                          ),
                                          CustomBottomSheet(
                                            name: 'فدان/ م',
                                            list: listofMeasuer,
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount:
                                              listTotalFishesItem.value.length,
                                          itemBuilder: (context, i) {
                                            return TotalFishesItem(
                                              list: listofTypes,
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomTextButton(
                                      width: SizeConfig.screenWidth * 0.3,
                                      title: 'إضافة عدد من نوع آخر ',
                                      function: () {
                                        listTotalFishesItem.value
                                            .add(TotalFishesItem(
                                          list: listofTypes,
                                        ));
                                        totalFishesItem =
                                            listTotalFishesItem.value;
                                        listTotalFishesItem.value = [
                                          ...totalFishesItem
                                        ];
                                      },
                                    ),
                                    if (listTotalFishesItem.value.length > 1)
                                      CustomTextButton(
                                        title: 'مسح الحقل الاخير ',
                                        function: () {
                                          totalFishesItem.removeLast();
                                          listTotalFishesItem.value = [
                                            ...totalFishesItem
                                          ];
                                        },
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.screenHeight * 0.04),
                                      child: const CustomTextField(
                                        hint: 'نوع العلف',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.screenHeight * 0.04),
                                      child: const CustomTextField(
                                        hint: 'اسم الشركه',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const CustomTextField(
                                  hint: 'وزن السمكة الابتدائى بالجرام',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomTextField(
                                  hint: 'وزن السمكة المستهدف بالجرام',
                                ),
                              ],
                            ),
                          ),
                          CustomTextButton(
                            title: "حفظ",
                            function: () {
                              push(const ProfileScreen());
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
    ));
  }
}
