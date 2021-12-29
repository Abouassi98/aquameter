// ignore_for_file: must_be_immutable

import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/widgets/custom_new_dialog.dart';
import 'package:aquameter/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';


class ShopItem extends StatelessWidget {
  final String name, address;
  final int num;
  const ShopItem({
    Key? key,
    required this.name,
    required this.address,
    required this.num,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CustomDialog _dialog = CustomDialog();

    return Dismissible(
      key: const ValueKey(0),
      onDismissed: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
        } else {}
      },
      confirmDismiss: (DismissDirection direction) async {
        return await _dialog.showOptionDialog(
            context: context,
            msg: 'هل ترغب بحذف العميل؟',
            okFun: () {},
            okMsg: 'نعم',
            cancelMsg: 'لا',
            cancelFun: () {
              return;
            });
      },
      child: InkWell(
        onTap: () {
          push(const ProfileScreen());
        },
        child: Card(
          color: Colors.white,
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                // Shop Image
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 90.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/fish1.png'),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                // Shop Details
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      children: [
                        // Shop name and distance
                        Text(
                          name,
                          style: MainTheme.headingTextStyle.copyWith(
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          address,
                          style: MainTheme.headingTextStyle.copyWith(
                              fontSize: 10, color: const Color(0xFF8D8E98)),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  inactiveTrackColor: const Color(0xFF8D8E98),
                                  activeTrackColor: MainStyle.primaryColor,
                                  thumbColor: Colors.blue[400],
                                  overlayColor: const Color(0xff282759),
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 5),
                                  overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 7),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Slider(
                                    value: num.toDouble(),
                                    min: 0,
                                    max: 100,
                                    onChanged: (double newValue) {},
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '${num.toString()} %',
                              style: MainTheme.headingTextStyle.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                        //  View CVount
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
