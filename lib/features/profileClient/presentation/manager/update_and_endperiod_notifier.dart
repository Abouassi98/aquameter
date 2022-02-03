import 'dart:developer';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/network_utils.dart';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateAndDeletePeriodNotifier extends StateNotifier<void> {
  UpdateAndDeletePeriodNotifier(void state) : super(state);
  final NetworkUtils _utils = NetworkUtils();

  endPeriod({
    required int periodId,
    int? clientId,
    num? totalWeight,
    int? averageWeight,
    num? averageFooder,
    num? conversionRate,
  }) async {
    Response response = await _utils.requstData(url: 'periods/update', body: {
      "id": periodId,
      "status": 0,
      if (clientId != null) "user_id": HelperFunctions.getUser().data!.id,
      if (clientId != null) "client_id": clientId,
      if (totalWeight != null) "total_wieght": totalWeight,
      if (averageWeight != null) "avrage_wieght": averageWeight,
      if (averageFooder != null) "avrage_fooder": averageFooder,
      if (conversionRate != null) "conversion_rate": conversionRate,
    });

    log('period Ended${response.data}');
    if (response.statusCode == 200) {
    } else {
      log('error period Ended ');
    }
  }
}
