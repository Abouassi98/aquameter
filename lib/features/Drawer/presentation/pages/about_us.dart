import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/features/Drawer/presentation/widgets/about_item.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  final String title;
  const AboutUs({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
     Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            title,
            style: MainTheme.headingTextStyle,
          ),
          centerTitle: true,
        ),
        body: const Padding(
            padding: EdgeInsets.all(20), child: AboutItem(text: 'fff')),
      ),
    );
  
  }
}
