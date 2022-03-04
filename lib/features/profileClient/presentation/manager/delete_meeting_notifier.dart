import 'dart:developer';
import 'package:aquameter/core/utils/functions/network_utils.dart';

import 'package:dio/dio.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/meeting_all_model..dart';

final StateNotifierProvider<DeleteMeetingNotifier, Object?>
    meetingAllNotifier =
    StateNotifierProvider<DeleteMeetingNotifier, Object?>(
  (ref) => DeleteMeetingNotifier(null),
);

class DeleteMeetingNotifier extends StateNotifier<void> {
  DeleteMeetingNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  MeetingAllModel? meetingAllModel;

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
