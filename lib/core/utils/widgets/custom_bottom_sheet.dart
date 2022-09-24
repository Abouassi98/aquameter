import 'package:aquameter/core/themes/screen_utility.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../routing/navigation_service.dart';
import '../sizes.dart';

class CustomBottomSheet extends ConsumerStatefulWidget {
  final String name;
  final List list;
  final bool? staticList;
  final bool? newCity;
  final ValueChanged? onChange;
  const CustomBottomSheet({
    Key? key,
    required this.name,
    this.staticList,
    required this.list,
    this.onChange,
    this.newCity,
  }) : super(key: key);
  @override
  CustomBottomSheetState createState() => CustomBottomSheetState();
}

class CustomBottomSheetState extends ConsumerState<CustomBottomSheet> {
  String? selectedLabel;
  @override
  Widget build(BuildContext context) {
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
                  itemCount: widget.list.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            NavigationService.goBack(context);
                            setState(() {
                              if (widget.staticList == true) {
                                selectedLabel = widget.list[i]['name'];
                              } else {
                                selectedLabel = widget.list[i].name;
                              }
                            });
                            if (widget.onChange != null) {
                              if (widget.staticList == true) {
                                widget.onChange!(widget.list[i]['name']);
                              } else {
                                widget.onChange!(widget.list[i].id);
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              widget.staticList == true
                                  ? widget.list[i]['name']
                                  : widget.list[i].name,
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
        height: Sizes.fullScreenHeight(context) * 0.062,
        width: Sizes.fullScreenWidth(context) * 0.3,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black38),
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.newCity == true
                ? widget.name
                : selectedLabel ?? widget.name),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 11,
                backgroundColor: MainStyle.primaryColor,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
