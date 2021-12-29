// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignInButton extends StatelessWidget {
  final Function? onPressSignIn;
  final String? buttonText;
  final IconData? iconData;
  final Color? btnColor;
  final Color? txtColor;
  final Color? iColor;
  final double? btnWidth;
  final double? textSize;
  final double? btnHeight;
  final bool load;
  final BorderRadiusGeometry? bRadius;
  final List<BoxShadow>? btnShadow;
  const SignInButton(
      {Key? key,
      this.onPressSignIn,
      this.buttonText,
      this.iconData,
      this.btnColor,
      this.iColor,
      this.txtColor,
      this.btnHeight,
      this.btnWidth,
      this.textSize,
      this.bRadius,
      this.btnShadow,
      this.load = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (load) {
      return Center(
        child: SpinKitFadingCircle(
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      );
    } else {
      return InkWell(
        onTap: onPressSignIn as void Function()?,
        child: Container(
            width: btnWidth,
            height: btnHeight,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: btnColor != null
                      ? [btnColor!, btnColor!]
                      : [
                          Theme.of(context).primaryColor,
                          Theme.of(context).colorScheme.secondary
                        ]),
              borderRadius: bRadius,
              // new BorderRadius.circular(50.0),
              boxShadow: btnShadow,

              //  [
              //   BoxShadow(color: Colors.black26, spreadRadius: 1, blurRadius: 5)
              // ],
            ),
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: onPressSignIn as void Function()?,
                      elevation: 3,
                      child: Text(
                        buttonText!,
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: txtColor,
                          fontSize: textSize ?? 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: iconData != null,
                      child: Icon(
                        iconData,
                        color: iColor,
                      ),
                    )
                  ],
                )
              ],
            )),
      );
    }
  }
}
