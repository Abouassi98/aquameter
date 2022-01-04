import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';

import 'package:aquameter/features/Home/Data/transaction_model.dart';
import 'package:aquameter/features/Home/presentation/manager/departments_notifier.dart';
import 'package:aquameter/features/Home/presentation/widgets/custom_client.dart';
import 'package:aquameter/features/Home/presentation/widgets/days_item.dart';
import 'package:aquameter/features/Home/presentation/pages/search_screen.dart';
import 'package:aquameter/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends HookConsumerWidget {
  Home({Key? key}) : super(key: key);

  final List<Transaction> _userTransactions = [];

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  final List<Object> name = [
    'الحاج محمود مصطفي محمد',
    'مهندس محمد طارق عباس',
  ];
  final List<Object> address = [
    'كفرالشيخ - طريق بلطيم',
    'بورسعيد - مثلث الديبه'
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DepartMentProvider departMent = ref.read(departMentProvider.notifier);
    departMent.recentTransactions = recentTransactions;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: MainStyle.backGroundColor,
        body: ListView(
          primary: false,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  height: SizeConfig.screenHeight * 0.17,
                  width: SizeConfig.screenWidth * 0.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'خطتك هذا الاسبوع',
                          style: MainTheme.headingTextStyle
                              .copyWith(fontSize: 13, color: Colors.black),
                        ),
                      ),
                      Expanded(child: DaysItem()),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenHeight,
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: () {
                          push(const SearchScreen());
                        },
                        child: const Text('اضافه عميل'),
                      ),
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: name.length,
                      itemBuilder: (context, i) => ShopItem(
                        func: () {
                          push(ProfileScreen());
                        },
                        num: 6,
                        name: name[i] as String,
                        address: address[i] as String,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
