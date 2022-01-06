import 'dart:developer';

import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/Data/clients_model/delete_client.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';

import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class GetClientsNotifier extends StateNotifier<AsyncValue<ClientsModel>> {
  GetClientsNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  DeleteClientModel? _model;
  ClientsModel? clientsModel;
  ClientsModel? filtersModel;

  Future<ClientsModel> getClients({int? fishTypeId}) async {
    Response response = await _utils.requstData(url: 'clients', body: {
      if (fishTypeId != null) 'fish_type': fishTypeId,
    });
    if (response.statusCode == 200) {
      if (fishTypeId != null) {
        filtersModel = ClientsModel.fromJson(response.data);
      } else {
        clientsModel = ClientsModel.fromJson(response.data);
      }

      log('correct get data');
    } else {
      log('error get data');
    }
    return clientsModel!;
  }

  deleteClient(int? clientId) async {
    Response response = await _utils.requstData(
      url: 'clients/delete/$clientId',
    );
    _model = DeleteClientModel.fromJson(response.data);
    if (response.statusCode == 200) {
      log('order deleteded');

      return _model;
    } else {
      log('error ');
    }
  }

  createMetting({required String date, required int clientId}) async {
    Response response = await _utils.requstData(
        url: 'meeting/create', body: {"meeting": date, "client_id": clientId});
    if (response.statusCode == 200) {
      log('meeting create');
      pushAndRemoveUntil(const MainPage());
    } else {
      log('error ');
    }
  }
}
