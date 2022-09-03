import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LimitRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      var value = int.parse(newValue.text);

      if (value < min) {
        return TextEditingValue(text: min.toString());
      } else if (value > max) {
        return TextEditingValue(text: max.toString());
      }
    } on FormatException {
      debugPrint('Format e rror!');
    }
    return newValue;
  }
}
