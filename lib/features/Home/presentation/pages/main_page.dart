import 'dart:developer';
import 'package:aquameter/core/screens/popup_page.dart';
import 'package:aquameter/core/utils/widgets/custom_appbar.dart';
import 'package:aquameter/features/Drawer/drawer_menu.dart';
import 'package:aquameter/features/profileClient/presentation/pages/add_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/themes/themes.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/services/localization_service.dart';
import '../../../../core/utils/services/storage_service.dart';
import '../../../../core/utils/sizes.dart';
import '../../../../core/utils/widgets/custom_new_dialog.dart';
import '../../../../core/utils/widgets/custom_option_dialog.dart';
import 'statics.dart';
import 'home.dart';

final CustomWarningDialog dialog = CustomWarningDialog();

final StateProvider<int> _bottomNavIndexProvider =
    StateProvider<int>(((ref) => 0));

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> widgets = [
      Home(ref: ref),
      const Statics(),
    ];
    int bottomNavIndex = ref.watch(_bottomNavIndexProvider);
    log('Token >>> ${StorageService.instance.restoreToken()}');
    return PopUpPage(
      drawer: const DrawerMenu(),
      extendBodyBehindAppBar: true,
      consumerAppBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.appBarCustomHeight(context) * 0.8),
        child: const CustomAppBar(
          drawer: true,
          search: false,
        ),
      ),
      onWillPop: () async {
      
        return await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => CustomOptionDialog(
                function: () => SystemNavigator.pop(), title: 'هل تود الخروج'));
      },
      body: widgets[bottomNavIndex],
      bottomNavigationBar: PlatformNavBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: tr(context).home,
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.timeline), label: tr(context).statics)
          ],
          backgroundColor: Colors.grey[200],
          itemChanged: (v) {
            ref.read(_bottomNavIndexProvider.state).state = v;
          },
          currentIndex: bottomNavIndex,
          material: ((context, platform) => MaterialNavBarData(
                selectedLabelStyle: MainTheme.hintTextStyle,
                unselectedLabelStyle: MainTheme.subTextStyle2,
                unselectedIconTheme:
                    const IconThemeData(color: Colors.grey, size: 25),
                unselectedItemColor: Colors.black,
                selectedItemColor: const Color.fromRGBO(16, 107, 172, 1),
                iconSize: 25,
                type: BottomNavigationBarType.fixed,
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.push(context,
              page: const AddClient(
                fromSearch: false,
              ),
              isNamed: false);
        },
        backgroundColor: const Color(0xff91dced),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
