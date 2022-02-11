import 'dart:developer';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/Data/three_values_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GetThreeValuesNotifier
    extends StateNotifier<AsyncValue<ThreeValuesModel>> {
  GetThreeValuesNotifier()
      : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  ThreeValuesModel? threeValuesModel;


  Future<ThreeValuesModel> getValues() async {
    Response response = await _utils.requstData(url: 'values', body: {});
    if (response.statusCode == 200) {
      threeValuesModel = ThreeValuesModel.fromJson(response.data);

      log('correct get values');
    } else {
      log('error get values');
    }
    return threeValuesModel!;
  }

}
