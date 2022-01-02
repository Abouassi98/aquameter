
import 'package:aquameter/core/themes/themes.dart';
import 'package:flutter/material.dart';

class AlertCalCulator extends StatelessWidget {
  final String title, advice1, advice2;
  final String? advice3, advice4;
  const AlertCalCulator(
      {Key? key,
      required this.title,
      required this.advice1,
      required this.advice2,
      this.advice3,
      this.advice4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: MainTheme.headingTextStyle
                  .copyWith(color: Colors.red, fontSize: 15),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'ننصحك بالآتي : ',
              style: MainTheme.subTextStyle2.copyWith(fontSize: 12),
            ),
          ),
          Text(
            advice1,
            style: MainTheme.subTextStyle2,
          ),
          const SizedBox(height: 5),
          Text(
            advice2,
            style: MainTheme.subTextStyle2,
          ),
          const SizedBox(height: 5),
          if (advice3 != null)
            Text(
              advice3!,
              style: MainTheme.subTextStyle2,
            ),
          const SizedBox(height: 5),
          if (advice4 != null)
            Text(
              advice4!,
              style: MainTheme.subTextStyle2,
            ),
          const SizedBox(height: 5),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
