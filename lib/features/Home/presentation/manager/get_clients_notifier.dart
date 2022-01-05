import 'dart:developer';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';
import 'package:aquameter/features/Home/Data/clients_model/delete_client.dart';
import 'package:aquameter/features/Home/presentation/pages/search_screen.dart';
import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class GetClientsNotifier extends StateNotifier<AsyncValue<List<Datum>>> {
  GetClientsNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();
  late Datum datum;
  DeleteClientModel? _model;

  List<Datum> datums = [];

  Future<List<Datum>> getClients({int? cityId}) async {
    datums = [];
    Response response = await _utils.requstData(
      url: 'clients',
      body: {
        'governorate': cityId

        // if (cityId == null) {'governorate': null} else {'governorate': cityId}
      },
    );
    if (response.statusCode == 200) {
      response.data['data'].forEach(
        (element) {
          datums.add(Datum.fromJson(element));
        },
      );
      log('correct get data');
    } else {
      log('error get data');
    }
    return datums.reversed.toList();
  }

  deleteClient(int? clientId) async {
    Response response = await _utils.requstData(
      url: 'clients/delete/$clientId',
    );
    _model = DeleteClientModel.fromJson(response.data);
    if (response.statusCode == 200) {
      log('order deleteded');
      push(SearchScreen());
      return _model;
    } else {
      log('error ');
    }
  }
}
