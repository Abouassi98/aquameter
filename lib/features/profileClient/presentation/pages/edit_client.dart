import 'dart:developer';

import 'package:aquameter/core/GlobalApi/AreaAndCities/Data/cities_model/area_and_cities_model.dart';
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';

import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/convert_arabic_numbers_to_english_number.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/size_config.dart';

import 'package:aquameter/core/utils/widgets/custom_header_title.dart';

import 'package:aquameter/features/CustomMap/presentation/pages/custom_map.dart';
import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';

import 'package:aquameter/features/profileClient/presentation/manager/meeting_all_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/widgets/total_fishes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import '../../../../core/themes/themes.dart';
import '../../../CustomMap/presentation/manager/map_notifier.dart';

// ignore: must_be_immutable
class EditClient extends ConsumerWidget {
  final Client client;
  EditClient({required this.client, Key? key}) : super(key: key);
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

  String? phone, name, landSizeType, company, feed;
  num? landSize, targetWeight, startingWeight;
  int? governorateId, areaId;
  List<int> totalFishes = [], typeFishes = [];
  int totalFishes1 = 0, typeFishes1 = 0;
  int? totalFishes2, totalFishes3, typeFishes2, typeFishes3;

  List<TotalFishesItem> totalFishesItem = [];
  StateProvider<bool> newCityProvider = StateProvider<bool>((ref) => false);
  StateProvider<List<Cities>> listOfCitiesProvider =
      StateProvider<List<Cities>>((ref) => []);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool newCity = ref.watch(newCityProvider);

    final MeetingAllNotifier meetingAll = ref.read(meetingAllNotifier.notifier);

    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    final AddClientNotifier updateClient = ref.read(
      addClientNotifier.notifier,
    );
    List<Cities>? listOfCities = ref.watch(listOfCitiesProvider);
    final MapNotifier map = ref.read(
      mapNotifier.notifier,
    );
    final address = ref.watch(mapAddress);
    areaAndCites.getCities(cityId: client.governorateData!.id);
    listOfCities = areaAndCites.areasModel!.data!;
    // ValueNotifier<bool> showSecondField = useState<bool>(false);
    // ValueNotifier<bool> showThirdField = useState<bool>(false);
    List<int> totalFishes = [], typeFishes = [];
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
                                    title: "تعديل بيانات العميل "),
                                const SizedBox(height: 15),
                                CustomTextField(
                                  width: SizeConfig.screenWidth * 0.7,
                                  icon: Icons.person,
                                  initialValue: client.name,
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
                                  initialValue: client.phone.toString(),
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
                                      name: areaAndCites.governorateModel!.data!
                                          .firstWhere((element) =>
                                              element.id == client.governorate)
                                          .name
                                          .toString(),
                                      list:
                                          areaAndCites.governorateModel!.data!,
                                      onChange: (v) async {
                                        areaId = 0;
                                        await areaAndCites.getCities(cityId: v);
                                        ref
                                                .read(listOfCitiesProvider.state)
                                                .state =
                                            areaAndCites.areasModel!.data!;
                                        governorateId = v;
                                        ref.read(newCityProvider.state).state =
                                            true;
                                      },
                                    ),
                                    CustomBottomSheet(
                                      newCity: newCity,
                                      name: newCity == true
                                          ? 'المدينه'
                                          : client.areaData!.names!,
                                      list: listOfCities,
                                      onChange: (v) {
                                        areaId = v;
                                        ref.read(newCityProvider.state).state =
                                            false;
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    map.initialLat = 30.3;
                                    map.initialLong = 31.3;
                                    push(CustomMap(
                                      address: client.address,
                                    ));
                                  },
                                  child: Container(
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
                                            child: Text(
                                                address ?? client.address!,
                                                style: MainTheme.hintTextStyle
                                                    .copyWith(
                                                        color: Colors.black),
                                                maxLines: null)),
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
                                const CustomHeaderTitle(
                                    title: 'بيانات المزرعه'),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.9,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'مساحه الارض',
                                            style: MainTheme.hintTextStyle,
                                          ),
                                          Text(
                                            'نوع/م',
                                            style: MainTheme.hintTextStyle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: SizeConfig.screenHeight *
                                                    0.04),
                                            child: CustomTextField(
                                              paste: false,
                                              type: TextInputType.phone,
                                              validator: (v) {
                                                if (v!.isEmpty) {
                                                  return 'لا يجب ترك الحقل فارغ';
                                                }
                                                return null;
                                              },
                                              initialValue:
                                                  client.landSize.toString(),
                                              onChange: (v) {
                                                landSize = num.parse(v);
                                              },
                                            ),
                                          ),
                                          CustomBottomSheet(
                                            staticList: true,
                                            name: client.landSizeType!,
                                            list: listofMeasuer,
                                            onChange: (v) {
                                              landSizeType = v;
                                              debugPrint(v);
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'اجمالي الاسماك',
                                            style: MainTheme.hintTextStyle,
                                          ),
                                          Text(
                                            'النوع',
                                            style: MainTheme.hintTextStyle,
                                          ),
                                        ],
                                      ),
                                      TotalFishesItem(
                                        initialvalue: client.fish![0].number,
                                        typeOfFish:
                                            client.fish![0].fishType!.name,
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
                                      //     initialvalue:
                                      //         client.totalNumber.toString(),
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
                                      //     initialvalue:
                                      //         client.totalNumber.toString(),
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
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'نوع العلف',
                                      style: MainTheme.hintTextStyle,
                                    ),
                                    Text(
                                      'اسم الشركه',
                                      style: MainTheme.hintTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.screenHeight * 0.04),
                                      child: CustomTextField(
                                        hint: client.feed ?? 'نوع العلف',
                                        onChange: (v) {
                                          feed = v;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.screenHeight * 0.04),
                                      child: CustomTextField(
                                        hint: client.company ?? 'اسم الشركه',
                                        onChange: (v) {
                                          company = v;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'وزن السمكه الابتدائي بالجرام',
                                  style: MainTheme.hintTextStyle,
                                ),
                                CustomTextField(
                                  initialValue:
                                      client.startingWeight.toString(),
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
                                Text(
                                  'وزن السمكه المستهدف بالجرام',
                                  style: MainTheme.hintTextStyle,
                                ),
                                CustomTextField(
                                  initialValue: client.targetWeight.toString(),
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
                              if (newCity == true) {
                                HelperFunctions.errorBar(context,
                                    message: 'يجب عليك اختيار مدينه');
                              } else {
                                totalFishes.add(totalFishes1 != 0
                                    ? totalFishes1
                                    : int.parse(client.fish![0].number!));
                                typeFishes.add(typeFishes1 != 0
                                    ? typeFishes1
                                    : client.fish![0].fishType!.id!);
                                // if (totalFishes2 != null) {
                                //   totalFishes.add(totalFishes2!);
                                //   typeFishes.add(typeFishes2!);
                                // }
                                // if (totalFishes3 != null) {
                                //   totalFishes.add(totalFishes3!);
                                //   typeFishes.add(typeFishes3!);
                                // }
                                updateClient.totalFishesupdate = totalFishes;
                                updateClient.typeFishesupdate = typeFishes;
                                meetingAll.isInit = false;
                                updateClient.updateClient(
                                  context: context,
                                  clientId: client.id!,
                                  phone: phone ?? client.phone.toString(),
                                  name: name ?? client.name!,
                                  governorateId:
                                      governorateId ?? client.governorate!,
                                  areaId: areaId ?? client.area!,
                                  landSize: landSize ?? client.landSize!,
                                  startingWeight:
                                      startingWeight ?? client.landSize!,
                                  targetWeight:
                                      targetWeight ?? client.targetWeight!,
                                  landSizeType: landSizeType ??
                                      client.landSize!.toString(),
                                  company: company ?? client.company,
                                  feed: feed ?? client.feed,
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
    ));
  }
}
