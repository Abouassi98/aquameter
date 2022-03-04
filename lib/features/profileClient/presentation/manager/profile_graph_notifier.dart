import 'dart:developer';
import 'package:aquameter/core/utils/functions/network_utils.dart';

import 'package:aquameter/features/profileClient/data/profile_graph_model.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/period_results_model.dart';

final StateNotifierProvider<ProfileClientNotifer, Object?>
    profileClientNotifer = StateNotifierProvider<ProfileClientNotifer, Object?>(
  (ref) => ProfileClientNotifer(),
);

class ProfileClientNotifer extends StateNotifier {
  ProfileClientNotifer() : super(null);
  final NetworkUtils _utils = NetworkUtils();
  bool isInit = false;
  int? clientId;
  ProfileGraphModel? profileGraphModel;
  PeriodResultsModel? periodResultsModel;
  Map<DateTime, List<CleanCalendarEvent>> selectedEvents = {};
  Future<PeriodResultsModel> getPeriodResults() async {
    Response response = await _utils.requstData(
      url: 'meetingResult/client/$clientId',
    );
    if (response.statusCode == 200) {
      selectedEvents.clear();
      await getProfileGraph();
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

  Future<ProfileGraphModel> getProfileGraph() async {
    Response response =
        await _utils.requstData(url: 'clients/graph', body: {'id': clientId});
    if (response.statusCode == 200) {
      profileGraphModel = ProfileGraphModel.fromJson(response.data);

      log('correct get data');
    } else {
      log('error get data');
    }
    return profileGraphModel!;
  }
}
