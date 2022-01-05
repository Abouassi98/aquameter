import 'package:aquameter/core/GlobalApi/fishTypes/Data/fish_types_model.dart';

import 'package:aquameter/core/utils/network_utils.dart';
import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class FishTypesNotifier extends StateNotifier<void> {
  FishTypesNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();

  late final FishTypesModel fishTypesModel;

  Future<FishTypesModel> getFishTypes() async {
    Response response = await _utils.requstData(
      url: 'fish_types',
    );
    if (response.statusCode == 200) {
      fishTypesModel = FishTypesModel.fromJson(response.data);
    } else {}
    return fishTypesModel;
  }
}
