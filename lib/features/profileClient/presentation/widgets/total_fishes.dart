import 'package:aquameter/core/GlobalApi/fishTypes/Data/fish_types_model.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';

import 'package:flutter/material.dart';

class TotalFishesItem extends StatelessWidget {
  final List<FishType> list;
  final String? initialvalue;
  final String? typeOfFish;

  final void Function()? onDelete;
  final ValueChanged<int>? onTotalFishesChange, onTypeFishesChange;

  const TotalFishesItem({
    Key? key,
    required this.list,
    this.initialvalue,
    this.typeOfFish,
    required this.onTotalFishesChange,
    required this.onTypeFishesChange,
    this.onDelete,
  }) : super(key: key);

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
            initialValue: initialvalue ?? 'إجمالى الأسماك',
            onChange: (v) {
              try {
                onTotalFishesChange!(int.parse(v));
              } on FormatException {
                debugPrint('Format error!');
              }
            },
          ),
        ),
        CustomBottomSheet(
          name: typeOfFish ?? 'النوع',
          list: list,
          onChange: (v) {
            onTypeFishesChange!(v);
          },
        ),
        if (onDelete != null)
          InkWell(
            child: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            onTap: onDelete,
          )
      ],
    );
  }
}
