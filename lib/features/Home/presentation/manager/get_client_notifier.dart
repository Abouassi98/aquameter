import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/functions/network_utils.dart';
import '../../Data/clients_model/client_model.dart';

final StateNotifierProvider<GetClientsNotifier, ClientsModel>
    getClientsNotifier =
    StateNotifierProvider<GetClientsNotifier, ClientsModel>(
  (ref) => GetClientsNotifier(),
);

class GetClientsNotifier extends StateNotifier<ClientsModel> {
  GetClientsNotifier() : super(ClientsModel());
  final NetworkUtils _utils = NetworkUtils();

  bool isInit = false;
  Future<ClientsModel> getClients() async {

    isInit = false;
    Response response = await _utils.requstData(url: 'clients', body: {});
    if (response.statusCode == 200) {
      state = ClientsModel.fromJson(response.data);
      debugPrint('correct get data');
    } else {
      debugPrint('error get data');
    }
    return state;
  }

  @override
  void dispose() {

    super.dispose();
  }
}
