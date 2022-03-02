import 'dart:developer';
import 'package:aquameter/core/utils/network_utils.dart';

import 'package:dio/dio.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/meeting_all_model..dart';

final AutoDisposeStateNotifierProvider<MeetingAllNotifier, Object?>
    meetingAllNotifier =
    StateNotifierProvider.autoDispose<MeetingAllNotifier, Object?>(
  (ref) => MeetingAllNotifier(null),
);

class MeetingAllNotifier extends StateNotifier<void> {
  MeetingAllNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  MeetingAllModel? meetingAllModel;


  bool isInit = false;
  DateTime selectedDay = DateTime.now();
  int? id;
  Future<MeetingAllModel> meetingAll({DateTime? start, DateTime? end}) async {
    isInit = false;

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
