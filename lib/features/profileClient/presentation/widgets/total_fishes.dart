import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class TotalFishesItem extends StatelessWidget {
  final List list;

  const TotalFishesItem({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.04),
          child: CustomTextField(
            type: TextInputType.phone,
          numbersOnly: true,
            hint: 'إجمالى الأسماك',
            onChange: (v){},
          ),
        ),
        CustomBottomSheet(
          name: 'النوع',
          list: list,
        ),
      ],
    );
  }
}
