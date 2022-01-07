import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/Data/home_clients_model/home_clients_model.dart';
import 'package:aquameter/features/profileClient/data/meeting_all_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeetingAllNotifier extends StateNotifier<void> {
  MeetingAllNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  MeetingAllModel? meetingAllModel;
  Map<DateTime, List<MeetingClient>> selectedEvents = {};
  List<MeetingClient> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  DateTime selectedDay = DateTime.now();
  int? id;
  Future<MeetingAllModel> meetingAll({DateTime? start, DateTime? end}) async {
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
        selectedEvents['date${[i]}']!.add(meetingAllModel!.data![i]);
      }
      print(selectedEvents);
    } else {}
    return meetingAllModel!;
  }
}
