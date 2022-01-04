import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_appbar.dart';

import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';

import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';

import 'package:aquameter/features/profile/presentation/pages/add_client.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Object> name = [
    'الحاج محمود مصطفي محمد',
    'مهندس محمد طارق عباس',
    'متولي زكريا القاضي',
    'الحاج محمود مصطفي محمد',
    'مهندس محمد طارق عباس',
    'متولي زكريا القاضي',
    'متولي زكريا القاضي',
  ];
  List<Object> address = [
    'كفرالشيخ - طريق بلطيم الدولي ',
    'بورسعيد - مثلث الديبه',
    'كفرالشيخ - طريق بلطيم الدولي ',
    'بورسعيد - مثلث الديبه',
    'كفرالشيخ - طريق بلطيم الدولي ',
    'بورسعيد - مثلث الديبه',
    'كفرالشيخ - طريق بلطيم الدولي ',
  ];
  List<Map<String, dynamic>> list = [
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي ',
    },
    {
      "name": 'مهندس محمد طارق عباس',
      "address": 'بورسعيد - مثلث الديبه',
    },
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي',
    },
    {
      "name": 'مهندس محمد طارق عباس',
      "address": 'بورسعيد - مثلث الديبه',
    },
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي',
    },
    {
      "name": 'مهندس محمد طارق عباس',
      "address": 'بورسعيد - مثلث الديبه',
    },
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي',
    },
  ];
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
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: MainStyle.backGroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            push(AddClient());
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          backgroundColor: const Color(0xff91dced),
        ),
        appBar: PreferredSize(
            child: const CustomAppBar(
              search: true,
              back: true,
            ),
            preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.2)),
        body: ListView(
          primary: false,
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBottomSheet(
                  name: 'المحافظات',
                  list: listofObject,
                ),
                CustomBottomSheet(
                  name: 'نوع العلف',
                  list: listofObject,
                ),
                CustomBottomSheet(
                  name: 'نوع السمك',
                  list: listofObject,
                ),
              ],
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                width: SizeConfig.screenWidth * .9,
                child: Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 10),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount:
                            HelperFunctions.getUser().data!.clients!.length,
                        itemBuilder: (context, index) => ClientItem(
                          func: () {
                            push(const MainPage());
                          },
                          client:
                              HelperFunctions.getUser().data!.clients![index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
