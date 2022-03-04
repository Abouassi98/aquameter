import 'package:aquameter/core/themes/themes.dart';

import 'package:flutter/material.dart';

class CustomBottomNavigationbBar extends StatelessWidget {
  final Function onTap;
  final int inx;
  const CustomBottomNavigationbBar({
    Key? key,
    required this.onTap,
    required this.inx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedLabelStyle: MainTheme.hintTextStyle,
        unselectedLabelStyle: MainTheme.subTextStyle2,
        unselectedIconTheme: const IconThemeData(color: Colors.grey, size: 25),
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color.fromRGBO(16, 107, 172, 1),
        iconSize: 25,
        currentIndex: inx,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[200],
        onTap: (index) {
          onTap(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسيه',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'الاحصائيات',
          ),
        ]);
  }
}
