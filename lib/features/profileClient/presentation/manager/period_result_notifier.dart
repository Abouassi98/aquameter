import 'dart:collection';
import 'dart:developer';
import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/period_results_model.dart';
import '../../data/table_events_utils.dart';

final StateNotifierProvider<PeriodResultsNotifier, Object?>
    periodResultsNotifier =
    StateNotifierProvider<PeriodResultsNotifier, Object?>(
  (ref) => PeriodResultsNotifier(),
);

class PeriodResultsNotifier extends StateNotifier<void> {
  PeriodResultsNotifier() : super(null);
  final NetworkUtils _utils = NetworkUtils();

  PeriodResultsModel? periodResultsModel;
  final LinkedHashMap<DateTime, List<Event>> kEvents =
      LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  late String date;
  bool isInit = false;
  Future<PeriodResultsModel> getClients(int clientId) async {
    isInit = false;
    Response response = await _utils
        .requstData(url: 'meetingResult/client/$clientId', body: {});
    if (response.statusCode == 200) {
      kEvents.clear();
      periodResultsModel = PeriodResultsModel.fromJson(response.data);

      kEvents.addAll({
        for (var item in List.generate(
            periodResultsModel!.data!.length, (index) => index))
          DateTime.utc(
              int.parse(
                  periodResultsModel!.data![item].realDate!.substring(0, 4)),
              int.parse(
                  periodResultsModel!.data![item].realDate!.substring(5, 7)),
              int.parse(periodResultsModel!.data![item].realDate!
                  .substring(8, 10))): List.generate(
              1, (index) => Event('Event $item | ${index + 1}'))
      });
  
     
      // for (int i = 0; i <; i++) {
      //   selectedEvents.addAll({
      //     DateTime(
      //       int.parse(periodResultsModel!.data![i].realDate!.substring(0, 4)),
      //       int.parse(periodResultsModel!.data![i].realDate!.substring(6, 7)),
      //       int.parse(
      //         periodResultsModel!.data![i].realDate!.substring(8, 10),
      //       ),
      //     ): [
      //       NeatCleanCalendarEvent(
      //         '',

      //         isMultiDay: true,
      //         color: Colors.white,
      //         startTime: DateTime(
      //           int.parse(
      //               periodResultsModel!.data![i].realDate!.substring(0, 4)),
      //           int.parse(
      //               periodResultsModel!.data![i].realDate!.substring(6, 7)),
      //           int.parse(
      //               periodResultsModel!.data![i].realDate!.substring(8, 10)),
      //         ),
      //         endTime: DateTime(
      //             int.parse(
      //                 periodResultsModel!.data![i].realDate!.substring(0, 4)),
      //             int.parse(
      //                 periodResultsModel!.data![i].realDate!.substring(6, 7)),
      //             int.parse(
      //                 periodResultsModel!.data![i].realDate!.substring(8, 10))),
      //       )
      //     ]
      //   });
      // }

      log('correct get data');
    } else {
      log('error get data');
    }
    return periodResultsModel!;
  }
}
