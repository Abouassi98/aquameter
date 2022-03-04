import 'dart:developer';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/functions/network_utils.dart';

import 'package:aquameter/features/Home/Data/clients_model/delete_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Data/clients_model/client_model.dart';

final StateNotifierProvider<GetAndDeleteClientsCreateMettingAndPeriodNotifier,
        Object?> getClientsNotifier =
    StateNotifierProvider<GetAndDeleteClientsCreateMettingAndPeriodNotifier,
        Object?>(
  (ref) => GetAndDeleteClientsCreateMettingAndPeriodNotifier(),
);

class GetAndDeleteClientsCreateMettingAndPeriodNotifier
    extends StateNotifier<AsyncValue<ClientsModel>> {
  GetAndDeleteClientsCreateMettingAndPeriodNotifier()
      : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  DeleteClientModel? _model;
  ClientsModel? clientsModel;
  Map<DateTime, List<CleanCalendarEvent>> selectedEvents = {};
  late String date;
  bool isInit = false;
  Future<ClientsModel> getClients() async {
    isInit = false;
    Response response = await _utils.requstData(url: 'clients', body: {});
    if (response.statusCode == 200) {
      selectedEvents.clear();
      clientsModel = ClientsModel.fromJson(response.data);
      for (int i = 0; i < clientsModel!.data!.length; i++) {
        for (int x = 0;
            x <
                clientsModel!
                    .data![i].onlinePeriodsResult![0].meetingResults!.length;
            x++) {
          selectedEvents.addAll({
            DateTime(
              int.parse(clientsModel!
                  .data![i].onlinePeriodsResult![0].meetingResults![x].realDate!
                  .substring(0, 4)),
              int.parse(clientsModel!
                  .data![i].onlinePeriodsResult![0].meetingResults![x].realDate!
                  .substring(6, 7)),
              int.parse(
                clientsModel!.data![i].onlinePeriodsResult![0]
                    .meetingResults![x].realDate!
                    .substring(8, 10),
              ),
            ): [
              CleanCalendarEvent('الزيارات السابقه',
                  startTime: DateTime(
                    int.parse(clientsModel!.data![i].onlinePeriodsResult![0]
                        .meetingResults![x].realDate!
                        .substring(0, 4)),
                    int.parse(clientsModel!.data![i].onlinePeriodsResult![0]
                        .meetingResults![x].realDate!
                        .substring(6, 7)),
                    int.parse(clientsModel!.data![i].onlinePeriodsResult![0]
                        .meetingResults![x].realDate!
                        .substring(8, 10)),
                  ),
                  description: 'زيارات مهمه',
                  isAllDay: true,
                  isDone: true,
                  endTime: DateTime(
                      int.parse(clientsModel!.data![i].onlinePeriodsResult![0]
                          .meetingResults![x].realDate!
                          .substring(0, 4)),
                      int.parse(clientsModel!.data![i].onlinePeriodsResult![0]
                          .meetingResults![x].realDate!
                          .substring(6, 7)),
                      int.parse(clientsModel!.data![i].onlinePeriodsResult![0]
                          .meetingResults![x].realDate!
                          .substring(8, 10))),
                  color: Colors.brown)
            ]
          });
        }
      }
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

  Future<void> createPeriod({
    required int clientId,
  }) async {
    Response response = await _utils.requstData(url: 'periods/create', body: {
      "mceeting": date,
      "client_id": clientId,
      "user_id": HelperFunctions.getUser().data!.id
    });
    if (response.statusCode == 200) {
      log('period create');
    } else {
      log('error ');
    }
  }
}
