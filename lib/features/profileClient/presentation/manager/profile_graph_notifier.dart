import 'dart:developer';
import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:aquameter/features/profileClient/data/profile_graph_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/period_results_model.dart';

final StateNotifierProvider<ProfileClientNotifer, Object?>
    profileClientNotifer = StateNotifierProvider<ProfileClientNotifer, Object?>(
  (ref) => ProfileClientNotifer(),
);

class ProfileClientNotifer extends StateNotifier {
  ProfileClientNotifer() : super(null);
  final NetworkUtils _utils = NetworkUtils();

  ProfileGraphModel? profileGraphModel;
  PeriodResultsModel? periodResultsModel;
  Future<ProfileGraphModel> getProfileGraph(int id) async {
    Response response =
        await _utils.requstData(url: 'clients/graph', body: {'id': id});
    if (response.statusCode == 200) {
      profileGraphModel = ProfileGraphModel.fromJson(response.data);

      log('correct get data');
    } else {
      log('error get data');
    }
    return profileGraphModel!;
  }
}
