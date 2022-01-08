import 'dart:developer';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateAndDeletePeriodNotifier extends StateNotifier<AsyncValue<ClientsModel>> {
  UpdateAndDeletePeriodNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  ClientsModel? clientsModel;

  endPeriod({required int periodId}) async {
    Response response = await _utils
        .requstData(url: 'periods/update', body: {"id": periodId, "status": 0});
    if (response.statusCode == 200) {
      log('period Ended');
    } else {
      log('error period Ended ');
    }
  }
}
