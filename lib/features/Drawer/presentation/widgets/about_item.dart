import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class AboutItem extends StatelessWidget {
  final String? text;


  const AboutItem({
    Key? key,
    this.text,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
      height: SizeConfig.screenHeight * 0.3,
              width: SizeConfig.screenWidth * 0.9,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(kAppLogo), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.05,
        ),
        Html(data: text, style: {
          'h1': Style(
            padding: const EdgeInsets.all(6),
            fontSize: const FontSize(12),
            alignment: Alignment.topLeft,
            color: MainStyle.primaryColor,
          ),
        }),
      ],
    );
  }
}
