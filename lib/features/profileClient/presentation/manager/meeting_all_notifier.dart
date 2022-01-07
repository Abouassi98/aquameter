import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/profileClient/data/meeting_all_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeetingAllNotifier extends StateNotifier<void> {
  MeetingAllNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  MeetingAllModel? meetingAllModel;
  int? id;
  Future<MeetingAllModel> meetingAll({DateTime? start, DateTime? end}) async {
    Response response = await _utils.requstData(
      body: FormData.fromMap({
        'id': id,
        'start': start,
        'end': end,
      }),
      url: 'clients/create',
    );

    if (response.statusCode == 200) {
      meetingAllModel = MeetingAllModel.fromJson(response.data);
    } else {}
    return meetingAllModel!;
  }
}
