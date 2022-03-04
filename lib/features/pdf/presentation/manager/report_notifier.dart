import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:aquameter/features/pdf/data/report_model.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


final AutoDisposeStateNotifierProvider<ReportNotifier, Object?>
reportNotifier =
StateNotifierProvider.autoDispose<ReportNotifier, Object?>(
      (ref) => ReportNotifier(null),
);

class ReportNotifier extends StateNotifier<void> {
  ReportNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  ReportModel? reportModel;

  Future<ReportModel> getReport({DateTime? start, DateTime? end,  int? clientId}) async {

    Response response = await _utils.requstData(
      body: FormData.fromMap({
        'clients[]': clientId,
        if (start != null) 'from': start,
        if (end != null) 'to': end,
      }),
      url: 'meetingResult/report',
    );

    if (response.statusCode == 200) {
      reportModel = ReportModel.fromJson(response.data);
      debugPrint('report model success');
    } else {
      debugPrint('report model failed');

    }
    return reportModel!;
  }

}
