import 'dart:developer';
import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:aquameter/core/utils/routing/route_paths.dart';
import 'package:aquameter/core/utils/services/storage_service.dart';
import 'package:aquameter/features/Home/Data/clients_model/delete_client.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../Data/clients_model/client_model.dart';

final StateNotifierProvider<DeleteClientsCreateMettingAndPeriodNotifier,
        Object?> deleteAndCreateClientsNotifier =
    StateNotifierProvider<DeleteClientsCreateMettingAndPeriodNotifier, Object?>(
  (ref) => DeleteClientsCreateMettingAndPeriodNotifier(),
);

class DeleteClientsCreateMettingAndPeriodNotifier
    extends StateNotifier<AsyncValue<ClientsModel>> {
  DeleteClientsCreateMettingAndPeriodNotifier()
      : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  DeleteClientModel? _model;

  late String date;

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
      NavigationService.pushReplacementAll(
        NavigationService.context,
        isNamed: true,
        page: RoutePaths.homeBase,
      );
    } else {
      log('error ');
    }
  }

  Future<void> createPeriod({
    required int clientId,
  }) async {
    Response response = await _utils.requstData(url: 'periods/create', body: {
      "mceeting": date,
      "client_id": clientId,
      "user_id": StorageService.instance.restoreUserData().data!.id
    });
    if (response.statusCode == 200) {
      log('period create');
    } else {
      log('error ');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
