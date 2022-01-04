import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:flutter/material.dart';

class ArcieveScreen extends StatelessWidget {
  ArcieveScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  List<String> names = [
    'الحاج محمد احمد سليم',
    'الحاج مصطفي محمد احمد',
  ];

  List<String> dates = [
    'دورة 13/6/2021',
    'دورة 10/6/2021',
    'دورة 11/8/2022',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    expandedAlignment: Alignment.bottomRight,
                    childrenPadding: EdgeInsets.only(right: 50),
                    title: Text(
                      names[index],
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Text(
                        dates[index],
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      )
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}
