import 'dart:developer';
import 'package:aquameter/core/utils/network_utils.dart';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/meeting_all_model..dart';

class MeetingAllNotifier extends StateNotifier<void> {
  MeetingAllNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  MeetingAllModel? meetingAllModel;
  Map<DateTime, List<CleanCalendarEvent>> selectedEvents = {};

  bool isInit = false;
  DateTime selectedDay = DateTime.now();
  int? id;
  Future<MeetingAllModel> meetingAll({DateTime? start, DateTime? end}) async {
    isInit = false;

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
      if (id != null) {
        for (int i = 0; i < meetingAllModel!.data!.length; i++) {
          for (int x = 0;
              x < meetingAllModel!.data![i].meetingResult!.length;
              x++) {
            selectedEvents.addAll({
              DateTime(
                int.parse(meetingAllModel!.data![i].meetingResult![x].realDate!
                    .substring(0, 4)),
                int.parse(meetingAllModel!.data![i].meetingResult![x].realDate!
                    .substring(6, 7)),
                int.parse(
                  meetingAllModel!.data![i].meetingResult![x].realDate!
                      .substring(8, 10),
                ),
              ): [
                CleanCalendarEvent('الزيارات السابقه',
                    startTime: DateTime(
                      int.parse(meetingAllModel!
                          .data![i].meetingResult![x].realDate!
                          .substring(0, 4)),
                      int.parse(meetingAllModel!
                          .data![i].meetingResult![x].realDate!
                          .substring(6, 7)),
                      int.parse(meetingAllModel!
                          .data![i].meetingResult![x].realDate!
                          .substring(8, 10)),
                    ),
                    endTime: DateTime(
                        int.parse(meetingAllModel!
                            .data![i].meetingResult![x].realDate!
                            .substring(0, 4)),
                        int.parse(meetingAllModel!
                            .data![i].meetingResult![x].realDate!
                            .substring(6, 7)),
                        int.parse(meetingAllModel!
                            .data![i].meetingResult![x].realDate!
                            .substring(8, 10))),
                    color: Colors.brown)
              ]
            });
          }
        }
      }
    } else {}
    return meetingAllModel!;
  }

  deleteMeeting({required int meetingId}) async {
    Response response = await _utils.requstData(
      url: 'meeting/delete/$meetingId',
    );
    if (response.statusCode == 200) {
      log('meeting deleted');
      await Fluttertoast.showToast(
          msg: 'تم ازالة الموعد بنجاح', toastLength: Toast.LENGTH_SHORT);
    } else {
      log('error ');
    }
  }
}
