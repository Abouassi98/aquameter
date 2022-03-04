import 'dart:developer';
import 'package:aquameter/core/utils/network_utils.dart';
import 'package:aquameter/features/archieve/data/archieve_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStateNotifierProvider<GetArchiveNotifier, Object?>
    getArchiveNotifier =
    StateNotifierProvider.autoDispose<GetArchiveNotifier, Object?>(
  (ref) => GetArchiveNotifier(),
);

class GetArchiveNotifier extends StateNotifier<AsyncValue<ArchieveModel>> {
  GetArchiveNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  ArchieveModel? archiveModel;

  Future<ArchieveModel> getArchives() async {
    Response response = await _utils.requstData(
      url: 'clients/archive',
    );
    if (response.statusCode == 200) {
      archiveModel = ArchieveModel.fromJson(response.data);

      log('correct get Archive data');
    } else {
      log('error get Archive data');
    }
    return archiveModel!;
  }
}
