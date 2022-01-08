import 'package:aquameter/core/utils/network_utils.dart';

import 'package:aquameter/features/profileClient/data/meeting_all_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeetingAllNotifier extends StateNotifier<void> {
  MeetingAllNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  MeetingAllModel? meetingAllModel;
  Map<DateTime, List<CleanCalendarEvent>> selectedEvents = {};

  bool isInit = false;
  DateTime selectedDay = DateTime.now();
  int? id;
  Future<MeetingAllModel> meetingAll({DateTime? start, DateTime? end}) async {
    selectedEvents.clear();
    Response response = await _utils.requstData(
      body: FormData.fromMap({
        if (id != null) 'id': id,
        if (start != null) 'start': start,
        if (end != null) 'end': end,
      }),
      url: 'meeting/all',
    );

    if (response.statusCode == 200) {
      meetingAllModel = MeetingAllModel.fromJson(response.data);
      for (int i = 0; i < meetingAllModel!.data!.length; i++) {
        selectedEvents.addAll({
          DateTime(
            int.parse(meetingAllModel!.data![i].meeting!.substring(0, 4)),
            int.parse(meetingAllModel!.data![i].meeting!.substring(6, 7)),
            int.parse(
              meetingAllModel!.data![i].meeting!.substring(8, 10),
            ),
          ): [
            CleanCalendarEvent('Event H',
                startTime: DateTime(
                  int.parse(meetingAllModel!.data![i].meeting!.substring(0, 4)),
                  int.parse(meetingAllModel!.data![i].meeting!.substring(6, 7)),
                  int.parse(
                      meetingAllModel!.data![i].meeting!.substring(8, 10)),
                ),
                endTime: DateTime(
                    int.parse(
                        meetingAllModel!.data![i].meeting!.substring(0, 4)),
                    int.parse(
                        meetingAllModel!.data![i].meeting!.substring(6, 7)),
                    int.parse(
                        meetingAllModel!.data![i].meeting!.substring(8, 10))),
                color: Colors.brown)
          ]
        });
      }
    } else {}
    return meetingAllModel!;
  }
}
