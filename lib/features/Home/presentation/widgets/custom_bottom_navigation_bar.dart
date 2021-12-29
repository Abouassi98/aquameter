import 'package:aquameter/core/themes/themes.dart';

import 'package:flutter/material.dart';

class CustomBottomNavigationbBar extends StatefulWidget {
  final Function onTap;
  final int inx;
  const CustomBottomNavigationbBar({
    Key? key,
    required this.onTap,
    required this.inx,
  }) : super(key: key);

  @override
  _CustomBottomNavigationbBarState createState() =>
      _CustomBottomNavigationbBarState();
}

class _CustomBottomNavigationbBarState
    extends State<CustomBottomNavigationbBar> {
  int inxShop = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedLabelStyle: MainTheme.hintTextStyle,
        unselectedLabelStyle: MainTheme.subTextStyle2,
        unselectedIconTheme: const IconThemeData(color: Colors.grey, size: 25),
        unselectedItemColor: Colors.black,
      
        iconSize: 25,
        currentIndex: widget.inx,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[200],
        onTap: (index) {
          setState(() {
            inxShop = index;
          });
          widget.onTap(index);
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
