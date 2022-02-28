import 'dart:developer';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/profileClient/data/profile_graph_model.dart';

import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';


class ProfileGraphNotifer extends StateNotifier<AsyncValue<ClientsModel>> {
  ProfileGraphNotifer() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  ProfileGraphModel? profileGraphModel;
  ClientsModel? clientsModel;

  late String date;

  Future<ClientsModel> getProfileGraph() async {
    Response response = await _utils.requstData(url: 'clients/graph', body: {});
    if (response.statusCode == 200) {
      profileGraphModel = ProfileGraphModel.fromJson(response.data);

      log('correct get data');
    } else {
      log('error get data');
    }
    return clientsModel!;
  }
}
