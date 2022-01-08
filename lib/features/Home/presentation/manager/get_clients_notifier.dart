import 'dart:developer';

import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/Data/clients_model/delete_client.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:aquameter/features/Home/presentation/pages/search_screen.dart';

import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class GetClientsNotifier extends StateNotifier<AsyncValue<ClientsModel>> {
  GetClientsNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  DeleteClientModel? _model;
  ClientsModel? clientsModel;

  late String date;

  Future<ClientsModel> getClients() async {
    Response response = await _utils.requstData(url: 'clients', body: {});
    if (response.statusCode == 200) {
      clientsModel = ClientsModel.fromJson(response.data);

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
      pushReplacement(SearchScreen());
      return _model;
    } else {
      log('error ');
    }
  }

  createMetting({required int clientId}) async {
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
