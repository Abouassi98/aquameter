import 'dart:developer';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/Data/home_clients_model/home_clients_model.dart';
import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class GetHomeClientsNotifier extends StateNotifier<AsyncValue<ClientsModel>> {
  GetHomeClientsNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  HomeClientsModel? homeClientsModel;

  Future<HomeClientsModel> getHomeClients() async {
    Response response = await _utils.requstData(
      url: 'meeting/all',
      
    );
    if (response.statusCode == 200) {

      homeClientsModel = HomeClientsModel.fromJson(response.data);
 
      log('correct getHomeClientsModel data');
    } else {
      log('error getHomeClientsModel data');
    }
    return homeClientsModel!;
  }

  
}

