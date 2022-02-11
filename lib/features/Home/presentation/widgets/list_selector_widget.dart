import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ListSelectorWidget extends HookConsumerWidget {
  final ClientsModel clientsModel;
  ListSelectorWidget({
    required this.clientsModel,
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormFieldState> _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
      MultiSelectBottomSheetField(
      key: _multiSelectKey,
      buttonIcon: const Icon(
        Icons.arrow_back_ios_new,
        size: 10,
      ),
      cancelText: const Text('الغاء'),
      confirmText: const Text('موافق'),
      listType: MultiSelectListType.LIST,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      title: const Text(
        '',
      ),
      buttonText: const Text(
        'اختار العميل',
        style: TextStyle(
          fontSize: 10,
        ),
      ),
      items:
          clientsModel.data!.map((e) => MultiSelectItem(e, e.name!)).toList(),
      searchable: true,
      onConfirm: (values) async {
        debugPrint('sdfsfdsfd  ${values.first}');
        if (values.isNotEmpty) {
        } else {}

        _multiSelectKey.currentState!.validate();
      },
      chipDisplay: MultiSelectChipDisplay(
        alignment: Alignment.topRight,
        onTap: (item) {
          _multiSelectKey.currentState!.validate();
        },
      ),
    );
  }
}
