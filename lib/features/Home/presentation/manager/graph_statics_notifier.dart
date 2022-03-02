import 'dart:developer';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/network_utils.dart';

import 'package:aquameter/features/Home/Data/graph_statics_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final AutoDisposeStateNotifierProvider<GraphStaticsNotifer, Object?>
    graphStaticsNotifer =
    StateNotifierProvider.autoDispose<GraphStaticsNotifer, Object?>(
  (ref) => GraphStaticsNotifer(),
);

class GraphStaticsNotifer extends StateNotifier<void> {
  GraphStaticsNotifer() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  GraphStaticsModel? graphStaticsModel;

  Future<GraphStaticsModel> getGraphStatics() async {
    Response response = await _utils.requstData(
        url: 'clients/graphAll',
        body: {'id': HelperFunctions.getUser().data!.id});
    if (response.statusCode == 200) {
      graphStaticsModel = GraphStaticsModel.fromJson(response.data);

      log('correct get data');
    } else {
      log('error get data');
    }
    return graphStaticsModel!;
  }
}
