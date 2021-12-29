import 'package:flutter/material.dart';

class CustomBtn extends StatefulWidget {
  final String? text;
  final Function? onTap;
  final Color? color;
  final Color? txtColor;
  final double? heigh;
  final double? weigh;
  const CustomBtn({
    Key? key,
    required this.text,
    required this.onTap,
    required this.color,
    this.txtColor,
    this.heigh,
    this.weigh,
  }) : super(key: key);

  @override
  _CustomBtnState createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heigh,
      width: widget.weigh,
      child: MaterialButton(
        onPressed: widget.onTap as void Function()?,
        color: widget.color,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: Text(
            widget.text!,
            textAlign: TextAlign.center,
            style:
                TextStyle(color: widget.txtColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
