import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class AddClientNotifier extends StateNotifier<void> {
  AddClientNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  AddClientNotifier? addClientNotifier;
  late String address, lat, long;
  List<int> totalFishes = [], typeFishes = [];
  Future<void> addClient(
      {required BuildContext context,
      required String phone,
      required String name,
      required int governorateId,
      required int areaId,
      required num landSize,
      required String landSizeType,
      required num targetWeight,
      required num startingWeight}) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'loading progress');
    Response response = await _utils.requstData(
      body: {
        "name": name,
        "phone": phone,
        "governorate": governorateId,
        "area": areaId,
        "address": "30.5",
        "land_size": landSize,
        "land_size_type": landSizeType,
        "starting_weight": startingWeight,
        "target_weight": targetWeight,
        "number": totalFishes,
        "type": typeFishes,
        "lat": "30.5",
        "long": "30.5"
      },
      url: 'clients/create',
    );

    if (response.statusCode == 200) {
      totalFishes.clear();
      typeFishes.clear();

      pushAndRemoveUntil(const MainPage());
    } else {}
  }
}
