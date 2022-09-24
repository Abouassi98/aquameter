import 'package:flutter/material.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/utils/services/localization_service.dart';
import '../../../../core/utils/widgets/custom_dialog.dart';
import '../manager/app_locale_provider.dart';
import '../../../Drawer/drawer_menu.dart';

class SelectLanguage {
  static show(
      {required BuildContext context,
      required AppLocaleNotifier appLocal}) async {
    final List<Widget> languageArray = [];
    final list = LanguageType.values.toList();

    for (var element in list) {
      languageArray.add(
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            appLocal.changeLocale(languageCode: element.name);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, bottom: 16, top: 16, right: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appLocal.languageType == element.name
                    ? const Icon(Icons.radio_button_checked)
                    : const Icon(Icons.radio_button_off),
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Text(data[element.index]))
              ],
            ),
          ),
        ),
      );
    }

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => CustomDialog(
        title: tr(context).selected_language,
        widget: [
          const Divider(
            height: 16,
          ),
          for (var item in languageArray) item,
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
