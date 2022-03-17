import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../functions/helper.dart';

class CustomWarningDialog {
  Future<dynamic> showWarningDialog(
      {required BuildContext context,
      required String msg,
      Function? btnOnPress}) {
    return AwesomeDialog(
            headerAnimationLoop: false,
            btnOkColor: Theme.of(context).primaryColor,
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            body: Center(child: Text(msg)),
            btnOkOnPress: btnOnPress,
            btnOkText: 'موافق')
        .show();
  }

  Future<dynamic> showErrorDialog(
      {required String msg,
      String? ok,
      required BuildContext context,
      Function? btnOnPress,
      int? code}) {
    return AwesomeDialog(
            headerAnimationLoop: false,
            btnOkColor: Theme.of(context).primaryColor,
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            body: Directionality(
                textDirection:
                    // localization.currentLanguage.toString() == "en"
                    //     ? TextDirection.ltr
                    //     :
                    TextDirection.rtl,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      msg,
                    ),
                  ),
                )),
            btnOkOnPress: btnOnPress,
            btnOkText: ok)
        .show();
  }

  Future<dynamic> showSuccessDialog(
      {required BuildContext context,
      required String msg,
      String? btnMsg,
      Function? btnOnPress}) {
    return AwesomeDialog(
            headerAnimationLoop: false,
            btnOkColor: Theme.of(context).primaryColor,
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            body: Directionality(
                textDirection:
                    // localization.currentLanguage.toString() == "en"
                    //     ? TextDirection.ltr
                    //     :
                    TextDirection.rtl,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      msg,
                    ),
                  ),
                )),
            btnOkOnPress: btnOnPress,
            btnOkText: btnMsg,
            aligment: Alignment.center)
        .show();
  }

  Future<dynamic> showOptionDialog(
      {required BuildContext context,
      required String msg,
      String? okMsg,
      void Function()? okFun,
      String? cancelMsg,
      Function? cancelFun}) {
    return AwesomeDialog(
            headerAnimationLoop: false,
            context: context,
            btnCancel: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                height: 30,
                child: const Center(
                    child: Text(
                  "لا",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            btnOk: InkWell(
              onTap: () {
                pop();
                okFun!();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(16, 107, 172, 1),),
                height: 30,
                child: const Center(
                    child: Text(
                      "نعم",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            btnOkColor: Theme.of(context).primaryColor,
            animType: AnimType.SCALE,
            dialogType: DialogType.NO_HEADER,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                msg,
                textAlign: TextAlign.right,
              )),
            ),
            btnOkOnPress: okFun,
            btnOkText: okMsg,
            btnCancelOnPress: cancelFun,
            btnCancelText: cancelMsg)
        .show();
  }

  Future<dynamic> showWidgetDialog({
    required BuildContext context,
    String? okMsg,
    Function? okFun,
    Widget? body,
  }) {
    return AwesomeDialog(
      headerAnimationLoop: false,
      context: context,
      btnOkColor: Theme.of(context).primaryColor,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: body,
      btnOkOnPress: okFun,
      btnOkText: okMsg,
    ).show();
  }
}
