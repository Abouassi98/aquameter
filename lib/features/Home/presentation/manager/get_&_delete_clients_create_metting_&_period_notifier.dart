import 'dart:developer';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/Data/clients_model/delete_client.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GetAndDeleteClientsCreateMettingAndPeriodNotifier
    extends StateNotifier<AsyncValue<ClientsModel>> {
  GetAndDeleteClientsCreateMettingAndPeriodNotifier()
      : super(const AsyncValue.loading());
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

  deleteClient({required int clientId}) async {
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

  createMetting({required int clientId}) async {
    Response response = await _utils.requstData(
        url: 'meeting/create', body: {"meeting": date, "client_id": clientId});
    if (response.statusCode == 200) {
      log('meeting create');
      // pushAndRemoveUntil(const MainPage());
    } else {
      log('error ');
    }
  }

  createPeriod({
    required int? clientId,
    required int? userId,
  }) async {
    Response response = await _utils.requstData(
        url: 'periods/create',
        body: {"mceeting": date, "client_id": clientId, "user_id": userId});
    if (response.statusCode == 200) {
      log('period create');
    } else {
      log('error ');
    }
  }
}
