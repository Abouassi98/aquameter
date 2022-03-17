import 'dart:developer';

import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_appbar.dart';
import 'package:aquameter/core/utils/widgets/custom_option_dialog.dart';
import 'package:aquameter/features/Drawer/drawer_menu.dart';
import 'package:aquameter/features/localization/manager/app_localization.dart';
import 'package:aquameter/features/profileClient/presentation/pages/add_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_storage/get_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/widgets/custom_new_dialog.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'statics.dart';
import 'home.dart';

class MainPage extends ConsumerWidget {
  MainPage({Key? key}) : super(key: key);

  final StateProvider<int> _bottomNavIndexProvider =
      StateProvider<int>(((ref) => 0));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _bottomNavIndex = ref.watch(_bottomNavIndexProvider);
    final List<Widget> widgets = [
      Home(),
      Statics(),
    ];
    log("Token=${GetStorage().read(kToken)}");
    final CustomWarningDialog _dialog = CustomWarningDialog();

    return WillPopScope(
      onWillPop: () async {
        return await _dialog.showOptionDialog(
            okFun: () => SystemNavigator.pop(),
            context: context,
            msg: 'هل تود الخروج');
      },
      child: Directionality(
        textDirection: localization.currentLanguage.toString() == 'en'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          drawer: const DrawerMenu(),
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            child: CustomAppBar(
              drawer: true,
              search: false,
            ),
            preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.23),
          ),
          extendBody: true,
          body: widgets[_bottomNavIndex],
          bottomNavigationBar: BottomAppBar(
            child: CustomBottomNavigationbBar(
              onTap: (v) {
                ref.read(_bottomNavIndexProvider.state).state = v;
              },
              inx: _bottomNavIndex,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              push(AddClient(
                fromSearch: false,
              ));
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
            backgroundColor: const Color(0xff91dced),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
