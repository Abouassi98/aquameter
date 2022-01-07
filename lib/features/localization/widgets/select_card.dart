import 'package:aquameter/features/localization/data/localization_model.dart';
import 'package:aquameter/features/localization/manager/change_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectCard extends HookConsumerWidget {
  final List<LocalizationModel> listOflocalizationModel;
  final ChangeLanguageProvider changeLanguage;

  const SelectCard({
    Key? key,
    required this.listOflocalizationModel,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<List<LocalizationModel>> selected =
        useState<List<LocalizationModel>>(listOflocalizationModel);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listOflocalizationModel.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  for (int i = 0; i < listOflocalizationModel.length; i++) {
                    listOflocalizationModel[i].selected = false;
                    selected.value = [...listOflocalizationModel];
                  }
                  listOflocalizationModel[index].selected =
                      !listOflocalizationModel[index].selected;

                  selected.value = [...listOflocalizationModel];

                  debugPrint(
                      listOflocalizationModel[index].selected.toString());
                  if (listOflocalizationModel[index].id == 1) {
                    changeLanguage.changeLang('ar');
                  } else if (listOflocalizationModel[index].id == 2) {
                    changeLanguage.changeLang('en');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    selected.value[index].selected
                        ? const Icon(Icons.check, color: Colors.black)
                        : Container(),
                    Row(
                      children: <Widget>[
                        Text(listOflocalizationModel[index].label,
                            style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 10),
                        CircleAvatar(
                            backgroundImage: AssetImage(
                                listOflocalizationModel[index].image),
                            radius: 30),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
