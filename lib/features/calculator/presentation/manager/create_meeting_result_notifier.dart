import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/Home/presentation/pages/main_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class CreateMeetingResultNotifier extends StateNotifier<void> {
  CreateMeetingResultNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  Future<void> createMeetingResult({
    required BuildContext context,
    required int meetId,
    required DateTime realDate,
    num? temperature,
    num? ph,
    num? salinity,
    num? oxygen,
    num? ammonia,
    num? avrageWieght,
    num? totalWeight,
    num? conversionRate,
    num? feed,
    int? deadFishes,
    num? toxicAmmonia,
    String? notes,
  }) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'loading progress');
    Response response = await _utils.requstData(
      body: {
        "meeting_id": meetId,
        "real_date" : realDate,
        if (temperature != null) "temperature": temperature,
        if (ph != null) "ph": ph,
        if (salinity != null) "salinity": salinity,
        if (oxygen != null) "oxygen": oxygen,
        if (ammonia != null) "ammonia": ammonia,
        if (avrageWieght != null) "avrage_wieght": avrageWieght,
        if (totalWeight != null) "total_weight": totalWeight,
        if (conversionRate != null) "conversion_rate": conversionRate,
        if (feed != null) "feed": feed,
        if (deadFishes != null) "dead_fish": deadFishes,
        if (toxicAmmonia != null) "toxic_ammonia": toxicAmmonia,
        if (notes != null) "notes": notes
      },
      url: 'meetingResult/create',
    );

    if (response.statusCode == 200) {
      pd.close();

      pushAndRemoveUntil(const MainPage());
    } else {}
  }
}
