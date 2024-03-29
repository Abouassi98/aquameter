import 'package:aquameter/core/GlobalApi/AreaAndCities/Data/cities_model/area_and_cities_model.dart';

import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateNotifierProvider<AreaAndCitesNotifier,Object?>
    areaAndCitesNotifier = StateNotifierProvider(
  (ref) => AreaAndCitesNotifier(),
);

class AreaAndCitesNotifier extends StateNotifier<void> {
  AreaAndCitiesModel? governorateModel;
  AreaAndCitesNotifier() : super(null);

  final NetworkUtils _utils = NetworkUtils();

  AreaAndCitiesModel? areasModel;

  Future<AreaAndCitiesModel> getCities({int? cityId}) async {
    Response response = await _utils.requstData(
      url: cityId == null ? 'areas/city' : 'areas/city/$cityId',
    );
    if (response.statusCode == 200) {
      if (cityId == null) {
        governorateModel = AreaAndCitiesModel.fromJson(response.data);
      } else {
        areasModel = AreaAndCitiesModel.fromJson(response.data);
      }
    } else {
      debugPrint('error Loading');
    }
    return AreaAndCitiesModel.fromJson(response.data);
  }
}
