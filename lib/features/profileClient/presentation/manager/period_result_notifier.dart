import 'dart:developer';
import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../data/period_results_model.dart';

final StateNotifierProvider<PeriodResultsNotifier, Object?> periodResultsNotifier =
    StateNotifierProvider<PeriodResultsNotifier, Object?>(
  (ref) => PeriodResultsNotifier(),
);

class PeriodResultsNotifier
    extends StateNotifier<void> {
  PeriodResultsNotifier() : super(null);
  final NetworkUtils _utils = NetworkUtils();

  PeriodResultsModel? periodResultsModel;
  Map<DateTime, List<CleanCalendarEvent>> selectedEvents = {};
  late String date;
  bool isInit = false;
  Future<PeriodResultsModel> getClients(int clientId) async {
    isInit = false;
    Response response = await _utils
        .requstData(url: 'meetingResult/client/$clientId', body: {});
    if (response.statusCode == 200) {
      selectedEvents.clear();
      periodResultsModel = PeriodResultsModel.fromJson(response.data);
      for (int i = 0; i < periodResultsModel!.data!.length; i++) {
        selectedEvents.addAll({
          DateTime(
            int.parse(periodResultsModel!.data![i].realDate!.substring(0, 4)),
            int.parse(periodResultsModel!.data![i].realDate!.substring(6, 7)),
            int.parse(
              periodResultsModel!.data![i].realDate!.substring(8, 10),
            ),
          ): [
            CleanCalendarEvent('الزيارات السابقه',
                startTime: DateTime(
                  int.parse(
                      periodResultsModel!.data![i].realDate!.substring(0, 4)),
                  int.parse(
                      periodResultsModel!.data![i].realDate!.substring(6, 7)),
                  int.parse(
                      periodResultsModel!.data![i].realDate!.substring(8, 10)),
                ),
                description: 'زيارات مهمه',
                isAllDay: true,
                isDone: true,
                endTime: DateTime(
                    int.parse(
                        periodResultsModel!.data![i].realDate!.substring(0, 4)),
                    int.parse(
                        periodResultsModel!.data![i].realDate!.substring(6, 7)),
                    int.parse(periodResultsModel!.data![i].realDate!
                        .substring(8, 10))),
                color: Colors.brown)
          ]
        });
      }

      log('correct get data');
    } else {
      log('error get data');
    }
    return periodResultsModel!;
  }
}
