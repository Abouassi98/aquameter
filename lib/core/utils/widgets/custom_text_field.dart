import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../size_config.dart';

class CustomTextField extends StatelessWidget {
  final String? hint, errorText;
  final int? maxLength, maxLines;
  final IconData? icon;
  final TextInputType? type;
  final ValueChanged<String>? onChange;
  final bool? edit, enabled, visibility, numbersOnly;
  final Widget? suffixIcon;
  final double? height, width;
  final Function? onChangeCountry, onInit;
  final TextEditingController? controller;
  final Color? fillColor;
  final String? Function(String?)? validator;
  const CustomTextField(
      {Key? key,
      this.hint,
      this.icon,
      this.type,
      this.maxLines,
      this.numbersOnly,
      this.errorText,
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
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? SizeConfig.screenWidth * 0.38,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: controller,
          obscureText: visibility ?? false,
          enabled: enabled ?? true,
          textAlign: TextAlign.right,
          inputFormatters: numbersOnly == true
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          keyboardType: type,
          onChanged: onChange,
          validator: validator,
          decoration: InputDecoration(
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
            errorText: errorText,
            floatingLabelBehavior: hint != null
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.only(
                top: icon != null ? SizeConfig.screenHeight * 0.045 : 0.0,
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
