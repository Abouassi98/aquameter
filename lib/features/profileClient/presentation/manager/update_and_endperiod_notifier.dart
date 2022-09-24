import 'dart:developer';
import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:aquameter/core/utils/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final StateNotifierProvider<UpdateAndDeletePeriodNotifier, Object?>
    updateAndDeletePeriodNotifier =
    StateNotifierProvider<UpdateAndDeletePeriodNotifier, Object?>(
  (ref) => UpdateAndDeletePeriodNotifier(null),
);

class UpdateAndDeletePeriodNotifier extends StateNotifier<void> {
  UpdateAndDeletePeriodNotifier(void state) : super(state);
  final NetworkUtils _utils = NetworkUtils();

  Future<void> endPeriod({
    required int periodId,
    required int clientId,
    num? totalWeight,
    num? averageWeight,
    int? totalNumber,
    num? averageFooder,
    num? conversionRate,
  }) async {
    Response response = await _utils.requstData(url: 'periods/update', body: {
      "id": periodId,
      "status": 0,
      "user_id": StorageService.instance.restoreUserData().data!.id,
      "client_id": clientId,
      if (totalWeight != null) "total_wieght": totalWeight,
      if (averageWeight != null) "avrage_wieght": averageWeight,
      if (averageFooder != null) "avrage_fooder": averageFooder,
      if (conversionRate != null) "conversion_rate": conversionRate,
      if (totalNumber != null) "total_number": totalNumber,
    });
    log('period Ended${response.data}');
    if (response.statusCode == 200) {
    } else {
      log('error period Ended ');
    }
  }
}
