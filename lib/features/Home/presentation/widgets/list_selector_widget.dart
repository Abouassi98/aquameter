import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/features/Home/presentation/manager/get_clients_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ListSelectorWidget extends HookConsumerWidget {
  ListSelectorWidget({
    Key? key,
  }) : super(key: key);

  final List list = [
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي ',
    },
    {
      "name": 'مهندس محمد طارق عباس',
      "address": 'بورسعيد - مثلث الديبه',
    },
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي',
    },
    {
      "name": 'مهندس محمد طارق عباس',
      "address": 'بورسعيد - مثلث الديبه',
    },
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي',
    },
    {
      "name": 'مهندس محمد طارق عباس',
      "address": 'بورسعيد - مثلث الديبه',
    },
    {
      "name": 'الحاج محمود مصطفي محمد',
      "address": 'كفرالشيخ - طريق بلطيم الدولي',
    },
  ];
  final String categoryName = '';

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<List> _selectedItems = useState<List>([]);
    List<int> ids = [];
    final GetClientsNotifier clients = ref.watch(getClientsNotifier.notifier);

    return MultiSelectBottomSheetField(
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            child: const Text("مسح الكل"),
            onPressed: () async {},
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: TextButton(
              child: const Text("تحديد الكل"),
              onPressed: () async {},
            ),
          ),
        ],
      ),
      buttonText: const Text(
        'اختار العميل',
        style: TextStyle(
          fontSize: 10,
        ),
      ),
      items: clients.clientsModel!.data!
          .map((e) => MultiSelectItem(e, e.name.toString()))
          .toList(),
      searchable: true,
      onConfirm: (values) async {
        ids = [];

        debugPrint('sdfsfdsfd${values.length}');
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            _selectedItems.value = values;
          }
          ids = ids.toSet().toList();
          for (int i = 0; i < ids.length; i++) {}
        } else {}

        _multiSelectKey.currentState!.validate();
      },
      chipDisplay: MultiSelectChipDisplay(
        alignment: Alignment.topRight,
        onTap: (item) {
          _selectedItems.value.remove(item);

          _multiSelectKey.currentState!.validate();
        },
      ),
    );
  }
}
