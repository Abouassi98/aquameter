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

import '../widgets/custom_bottom_navigation_bar.dart';
import 'statics.dart';
import 'home.dart';

class MainPage extends StatefulWidget {
  final int? index;
  const MainPage({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? appBartitle = localization.text('follow_order');
  List<Widget> widgets = [
    Home(),
    const Statics(),
  ];
  int _bottomNavIndex = 0;
  void selectedpage() {
    if (widget.index != null) {
      setState(() {
        _bottomNavIndex = widget.index!;
      });
    }
  }

  @override
  void initState() {
    selectedpage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("555555=${GetStorage().read(kToken)}");
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            useSafeArea: true,
            builder: (context) => CustomOptionDialog(
                  title: 'هل تود الخروج',
                  function: () => SystemNavigator.pop(),
                ));
      },
      child: Directionality(
        textDirection: localization.currentLanguage.toString() == 'en'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          drawer: const DrawerMenu(),
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            child: const CustomAppBar(
              drawer: true,
              search: false,
            ),
            preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.2),
          ),
          extendBody: true,
          body: widgets[_bottomNavIndex],
          bottomNavigationBar: BottomAppBar(
            child: CustomBottomNavigationbBar(
              onTap: (v) {
                setState(() {
                  _bottomNavIndex = v;
                });
              },
              inx: _bottomNavIndex,
            ),
          ),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
