import 'dart:developer';
import 'package:aquameter/core/GlobalApi/AreaAndCities/Data/cities_model/area_and_cities_model.dart';
import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/screens/popup_page.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/convert_arabic_numbers_to_english_number.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/services/localization_service.dart';
import 'package:aquameter/core/utils/widgets/custom_header_title.dart';
import 'package:aquameter/features/CustomMap/presentation/pages/custom_map_select_address.dart';
import 'package:aquameter/core/utils/widgets/custom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';
import 'package:aquameter/features/profileClient/presentation/widgets/total_fishes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import '../../../../core/themes/themes.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/sizes.dart';
import '../../../CustomMap/presentation/manager/map_notifier.dart';

final List<String> acceptedNumbers = [
  '012',
  '011',
  '015',
  '010',
];
final StateProvider<bool> newCityProvider = StateProvider<bool>((ref) => false);
final StateProvider<List<Cities>> listOfCitiesProvider =
    StateProvider<List<Cities>>((ref) => []);
final List<Map<String, dynamic>> listofMeasuer = [
  {'name': 'فدان', 'id': 1},
  {'name': 'م2', 'id': 2},
];
String phone = '', name = '', landSizeType = '', company = '', feed = '';
num landSize = 0, targetWeight = 0, startingWeight = 0;
int governorateId = 0, areaId = 0;
List<int> totalFishes = [], typeFishes = [];
int totalFishes1 = 0, typeFishes1 = 0;
int? totalFishes2, totalFishes3, typeFishes2, typeFishes3;

    final formKey = useMemoized(() => GlobalKey<FormState>());
class AddClient extends HookConsumerWidget {
  final bool fromSearch;
  const AddClient({Key? key, required this.fromSearch}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Cities> listOfCities = ref.watch(listOfCitiesProvider);
    final bool newCity = ref.watch(newCityProvider);
    final AreaAndCitesNotifier areaAndCites = ref.read(
      areaAndCitesNotifier.notifier,
    );
    final AddClientNotifier addClient = ref.read(
      addClientNotifier.notifier,
    );
    final address = ref.watch(mapAddress);
    return PopUpPage(
      body: Form(
        key: formKey,
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
                            height: Sizes.fullScreenHeight(context) * 0.1,
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
                                  width: Sizes.fullScreenWidth(context) * 0.75,
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
                                CustomTextField(
                                  showCounterTxt: true,
                                  hint: tr(context).phone,
                                  icon: Icons.phone,
                                  type: TextInputType.phone,
                                  numbersOnly: true,
                                  width: Sizes.fullScreenWidth(context) * 0.75,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomBottomSheet(
                                      name: 'المحافظة',
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
                                      name: 'المدينة',
                                      list: listOfCities,
                                      newCity: newCity,
                                      onChange: (v) {
                                        areaId = v;
                                        ref.read(newCityProvider.state).state =
                                            false;
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                InkWell(
                                  onTap: () {
                                    NavigationService.push(context,
                                        page: const CustomMapSelectAddress(),
                                        isNamed: false);
                                  },
                                  child: Container(
                                    width: Sizes.fullScreenWidth(context) * .75,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black38),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width:
                                              Sizes.fullScreenWidth(context) *
                                                  0.4,
                                          child: Text(
                                              address ??
                                                  'حرك المؤشر ليتم اختيار العنوان',
                                              style: MainTheme.hintTextStyle
                                                  .copyWith(
                                                      color: Colors.black),
                                              maxLines: null),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            child: const Icon(
                                              Icons.location_on,
                                              size: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const CustomHeaderTitle(
                                    title: 'بيانات المزرعة'),
                                SizedBox(
                                  width: Sizes.fullScreenWidth(context) * 0.9,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),

                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomTextField(
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
                                            hint: '     مساحة الأرض',
                                            onChange: (v) {
                                              try {
                                                landSize = num.parse(v);
                                              } on FormatException {
                                                debugPrint('Format error!');
                                              }
                                            },
                                          ),
                                          CustomBottomSheet(
                                            staticList: true,
                                            name: 'فدان/ م2',
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
                                    
                                    ],
                                  ),
                                ),
                               
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: CustomTextField(
                                        width: Sizes.fullScreenWidth(context) *
                                            .38,
                                        hint: '     نوع العلف',
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
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: CustomTextField(
                                        width: Sizes.fullScreenWidth(context) *
                                            .31,
                                        hint: 'اسم الشركة',
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
                              }
                             
                              else if (formKey.currentState!.validate()) {
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
                                    fromSearch: fromSearch);
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
                    onPressed: () {
                      NavigationService.goBack(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
