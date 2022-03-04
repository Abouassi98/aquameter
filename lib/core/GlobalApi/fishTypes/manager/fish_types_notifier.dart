import 'package:aquameter/core/GlobalApi/fishTypes/Data/fish_types_model.dart';

import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<FishTypesNotifier, Object?> fishTypesNotifier =
    StateNotifierProvider(
  (ref) => FishTypesNotifier(null),
);

class FishTypesNotifier extends StateNotifier<void> {
  FishTypesNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();

  FishTypesModel? fishTypesModel;

  Future<FishTypesModel> getFishTypes() async {
    Response response = await _utils.requstData(
      url: 'fish_types',
    );
    if (response.statusCode == 200) {
      fishTypesModel = FishTypesModel.fromJson(response.data);
    } else {}
    return fishTypesModel!;
  }
}
