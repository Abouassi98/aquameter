import 'dart:developer';

import 'package:aquameter/core/GlobalApi/AreaAndCities/Data/cities_model/area_and_cities_model.dart';
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';

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
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/manager/location_notifier.dart';

import 'package:aquameter/features/profileClient/presentation/widgets/total_fishes.dart';

import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  String phone = '', name = '', landSizeType = '';
  num landSize = 0, targetWeight = 0, startingWeight = 0;
  int governorateId = 0, areaId = 0;
  List<int> totalFishes = [], typeFishes = [];
  List<TotalFishesItem> totalFishesItem = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocationProvider location = ref.watch(locationProvider.notifier);
    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    final AddClientNotifier addClient = ref.read(
      addClientNotifier.notifier,
    );

    ValueNotifier<List<Cities>> listOfCities = useState<List<Cities>>([]);
    ValueNotifier<List<TotalFishesItem>> listTotalFishesItem =
        useState<List<TotalFishesItem>>([
      TotalFishesItem(
        list: ref
            .read(
              fishTypesNotifier.notifier,
            )
            .fishTypesModel!
            .data!,
      )
    ]);

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
                                    },
                                    suffixIcon: CustomCountryCodePicker(
                                      onChange: (Country value) {},
                                    ),
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
                                        list: areaAndCites.citiesModel!.data!,
                                        onChange: (v) async {
                                          await areaAndCites.getCities(
                                              cityId: v);
                                          listOfCities.value =
                                              areaAndCites.areasModel!.data!;
                                          governorateId = v;
                                        },
                                      ),
                                      CustomBottomSheet(
                                        name: 'المدينه',
                                        list: listOfCities.value,
                                        onChange: (v) {
                                          areaId = v;
                                        },
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
                                                hint: 'مساحة الأرض',
                                                onChange: (v) {
                                                  landSize = num.parse(v);
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
                                        ListView.builder(
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount: listTotalFishesItem
                                                .value.length,
                                            itemBuilder: (context, i) {
                                              return TotalFishesItem(
                                                list: ref
                                                    .read(
                                                      fishTypesNotifier
                                                          .notifier,
                                                    )
                                                    .fishTypesModel!
                                                    .data!,
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
                                            list: ref
                                                .read(
                                                  fishTypesNotifier.notifier,
                                                )
                                                .fishTypesModel!
                                                .data!,
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
                                            top:
                                                SizeConfig.screenHeight * 0.04),
                                        child: const CustomTextField(
                                          hint: 'نوع العلف',
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                                SizeConfig.screenHeight * 0.04),
                                        child: const CustomTextField(
                                          hint: 'اسم الشركه',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    hint: 'وزن السمكة الابتدائى بالجرام',
                                    onChange: (v) {
                                      startingWeight = num.parse(v);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    hint: 'وزن السمكة المستهدف بالجرام',
                                    onChange: (v) {
                                      targetWeight = num.parse(v);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            CustomTextButton(
                              title: "حفظ",
                              function: () {
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
                                );
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
