import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ListSelectorWidget extends StatefulWidget {
  const ListSelectorWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ListSelectorWidget> createState() => _ListSelectorWidgetState();
}

class _ListSelectorWidgetState extends State<ListSelectorWidget> {
  List list = [
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
  String categoryName = '';

  final _multiSelectKey = GlobalKey<FormFieldState>();
  List _selectedItems = [];
  int slected = 0;
  int subCatgoryId = 0;
  @override
  void initState() {
    super.initState();
  }

  String branId = '';
  String categoryId = '';
  String modelId = '';
  String regionId = '';
  String attributesId = '';
  List<int> ids = [];
  String names = '';
  @override
  Widget build(BuildContext context) {
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
      title: TextButton(
        child: const Text("مسح الكل"),
        onPressed: () async {},
      ),
      buttonText: const Text(
        'اختار العميل',
        style: TextStyle(fontSize: 10),
      ),
      items: list.map((e) => MultiSelectItem(e, e['name'])).toList(),
      searchable: true,
      onConfirm: (values) async {
        ids = [];

        debugPrint('sdfsfdsfd${values.length}');
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            _selectedItems = values;
          }
          ids = ids.toSet().toList();
          for (int i = 0; i < ids.length; i++) {}
        } else {}

        _multiSelectKey.currentState!.validate();
      },
      chipDisplay: MultiSelectChipDisplay(
        alignment: Alignment.topRight,
        onTap: (item) {
          setState(() {
            _selectedItems.remove(item);
          });
          _multiSelectKey.currentState!.validate();
        },
      ),
    );
  }
}
