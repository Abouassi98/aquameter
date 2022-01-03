// import 'package:aquafish/src/screens/MainWidgets/register_text_field.dart';
import 'package:aquameter/core/themes/screen_utitlity.dart';

import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/features/Home/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

// import 'defaultAppbar.dart';

class CustomAppBar extends StatelessWidget {
  final bool? search, back,drawer;


  final void Function(String)? onChange;

  const CustomAppBar({Key? key, this.search, this.onChange, this.back,this.drawer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: MainStyle.primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if(drawer==true)
              InkWell(
                child: const Icon(Icons.menu),
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
              if (back == true)
                InkWell(
                  child: const Icon(Icons.arrow_back_ios),
                  onTap: () {
                    pop();
                  },
                ),
              search == true
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: CustomTextField(
                        hint: 'بحث',
                        onChange: onChange,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        push(const SearchScreen());
                      }),
              SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                  width: 100,
                  child: Image.asset(
                    kAppLogo,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
          if (search != true || back != true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text(
                        '1.18',
                        style: TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'معدل التحويل',
                        style: TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        '17',
                        style: TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'الاسماك/طن',
                        style: TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        '20',
                        style: TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'الاعلاف/طن',
                        style: TextStyle(
                          color: Color(0xff282759),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
