import 'package:flutter/material.dart';

/// Page navigation pages
////////////////////////////////////////////////
final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

push(Widget child) {
  return Navigator.of(navigator.currentContext!)
      .push(MaterialPageRoute(builder: (context) => child));
}

pop() {
  return Navigator.of(navigator.currentContext!).pop();
}

replacement(Widget child) {
  return Navigator.of(navigator.currentContext!)
      .pushReplacement(MaterialPageRoute(builder: (context) => child));
}

pushAndRemoveUntil(Widget child) {
  return Navigator.of(navigator.currentContext!).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => child), (route) => false);
}

pushReplacement(Widget child) {
  return Navigator.of(navigator.currentContext!)
      .pushReplacement(MaterialPageRoute(builder: (context) => child));
}

////////////////////////////////////////////////

////////////////////////////////////////////////
/// Utilities
////////////////////////////////////////////////

bool emailvalidator(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

// void launchURL({required String url}) async {
//   String theUrl = Uri.encodeComponent(url);
//   if (await canLaunch(theUrl)) {
//     await launch(
//       theUrl,
//       forceSafariVC: false,
//       enableJavaScript: true,
//       forceWebView: true,
//       headers: <String, String>{'my_header_key': 'my_header_value'},
//     );
//   } else {
//     throw 'Could not launch $url';
//   }
// }
