import 'package:aquameter/core/GlobalApi/AreaAndCities/Data/cities_model/area_and_cities_model.dart';

import 'package:aquameter/core/utils/network_utils.dart';
import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class AreaAndCitesNotifier extends StateNotifier<void> {
  AreaAndCitesNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();

  late final AreaAndCitiesModel citiesModel;

  Future<AreaAndCitiesModel> getCities({int? cityId}) async {
    Response response = await _utils.requstData(
    
      url: cityId == null ? 'areas/city' : 'areas/city/$cityId',
    );
    if (response.statusCode == 200) {
      citiesModel = AreaAndCitiesModel.fromJson(response.data);
      return citiesModel;
    } else {
      return AreaAndCitiesModel.fromJson(response.data);
    }
  }
}
