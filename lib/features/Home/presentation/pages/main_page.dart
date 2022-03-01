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
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/custom_bottom_navigation_bar.dart';
import 'statics.dart';
import 'home.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> widgets = [
      Home(),
      Statics(),
    ];
    final ValueNotifier<int> _bottomNavIndex = useState<int>(0);
    log("Token=${GetStorage().read(kToken)}");
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
            child: CustomAppBar(
              drawer: true,
              search: false,
            ),
            preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.2),
          ),
          extendBody: true,
          body: widgets[_bottomNavIndex.value],
          bottomNavigationBar: BottomAppBar(
            child: CustomBottomNavigationbBar(
              onTap: (v) {
                _bottomNavIndex.value = v;
              },
              inx: _bottomNavIndex.value,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              push(AddClient(fromSearch: false,));
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
