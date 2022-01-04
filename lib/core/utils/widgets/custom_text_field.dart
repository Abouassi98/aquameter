import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../limit_range.dart';
import '../size_config.dart';
import 'decimal_text_input_formatter.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final int? maxLength, maxLines, minRange, maxRange;
  final IconData? icon;
  final TextInputType? type;
  final ValueChanged<String>? onChange;
  final bool? edit,
      enabled,
      visibility,
      numbersOnly,
      calculator,
      paste,
      showCounterTxt;
  final Widget? suffixIcon;
  final double? height, width;
  final Function? onChangeCountry, onInit;
  final TextEditingController? controller;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  const CustomTextField(
      {Key? key,
      this.hint,
      this.icon,
      this.type,
      this.maxLines,
      this.numbersOnly,
      this.onChange,
      this.edit,
      this.enabled,
      this.visibility,
      this.onChangeCountry,
      this.onInit,
      this.controller,
      this.validator,
      this.fillColor,
      this.height,
      this.width,
      this.maxLength,
      this.calculator,
      this.paste,
      this.minRange,
      this.maxRange,
      this.autovalidateMode,
      this.showCounterTxt,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? SizeConfig.screenWidth * 0.38,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          toolbarOptions: ToolbarOptions(
            copy: true,
            cut: true,
            paste: paste ?? true,
          ),
          controller: controller,
          obscureText: visibility ?? false,
          enabled: enabled ?? true,
          textAlign: TextAlign.right,
          inputFormatters: calculator == true
              ? <TextInputFormatter>[
                  DecimalTextInputFormatter(decimalRange: 3),
                  if (maxRange != null)
                    LimitRangeTextInputFormatter(minRange!, maxRange!),
                ]
              : numbersOnly == true
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : null,
          keyboardType: type,
          onChanged: onChange,
          autovalidateMode: autovalidateMode,
          validator: validator,
          decoration: InputDecoration(
            counterText: showCounterTxt == true ? null : '',
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
            filled: true,
            helperText: '',
            prefixIcon: icon != null
                ? Padding(
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                      icon,
                      color: Colors.grey,
                    ),
                  )
                : null,
            suffixIcon: suffixIcon,
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            floatingLabelBehavior: hint != null
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.only(
                top: icon != null ? SizeConfig.screenHeight * 0.02 : 0.0,
                right: 5),
            border: InputBorder.none,
          ),
          maxLength: maxLength,
          maxLines: maxLines ?? 1,
        ),
      ),
    );
  }
}
