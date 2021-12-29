import 'package:aquameter/core/themes/screen_utitlity.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../size_config.dart';

class CustomBottomSheet extends HookConsumerWidget {
  final String name;
  final List list;

  const CustomBottomSheet({
    Key? key,
    required this.name,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<String> selectedLabel = useState<String>('');

    return Container(
      height: SizeConfig.screenHeight * 0.08,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black38),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(selectedLabel.value != '' ? selectedLabel.value : name),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
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
                                    selectedLabel.value = list[i]['name'];
                                  },
                                  child: Center(
                                    child: Text(
                                      list[i]['name'],
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
              child: const CircleAvatar(
                radius: 11,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                backgroundColor: MainStyle.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
