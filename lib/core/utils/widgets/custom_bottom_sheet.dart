import 'package:aquameter/core/themes/screen_utility.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../size_config.dart';

class CustomBottomSheet extends HookConsumerWidget {
  final String name;
  final List list;
  final bool? staticList;
  final bool? newCity;
  final ValueChanged? onChange;
   CustomBottomSheet({
    Key? key,
    required this.name,
    this.staticList,
    required this.list,
    this.onChange,
    this.newCity,
  }) : super(key: key);
  StateProvider<String> selectedLabelProvider =
      StateProvider<String>((ref) => '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   String selectedLabel = ref.watch(selectedLabelProvider);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            elevation: 2,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            builder: (_) {
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            pop();
                            if (staticList == true) {
                              selectedLabel = list[i]['name'];
                            } else {
                              selectedLabel = list[i].name;
                            }
                            if (onChange != null) {
                              if (staticList == true) {
                                onChange!(list[i]['name']);
                              } else {
                                onChange!(list[i].id);
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              staticList == true
                                  ? list[i]['name']
                                  : list[i].name,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  });
            });
      },
      child: Container(
        height: SizeConfig.screenHeight * 0.08,
        width: SizeConfig.screenWidth * 0.3,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black38),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(newCity == true
                ? name
                : selectedLabel != ''
                    ? selectedLabel
                    : name),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 11,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                backgroundColor: MainStyle.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
