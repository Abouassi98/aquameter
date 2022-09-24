import 'dart:developer';
import 'package:aquameter/core/utils/functions/network_utils.dart';
import 'package:aquameter/features/Drawer/Data/about_terms_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateNotifierProvider<GetAboutAndTermsNotifier, Object?>
    getAboutAndTermsNotifier =
    StateNotifierProvider<GetAboutAndTermsNotifier, Object?>(
  (ref) => GetAboutAndTermsNotifier(),
);

class GetAboutAndTermsNotifier
    extends StateNotifier<AsyncValue<AboutAndTermsModel>> {
  GetAboutAndTermsNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  AboutAndTermsModel? aboutAndTermsModel;

  Future<AboutAndTermsModel> getAboutAndTerms() async {
    Response response = await _utils.requstData(url: 'setting', body: {});
    if (response.statusCode == 200) {
      aboutAndTermsModel = AboutAndTermsModel.fromJson(response.data);

      log('correct get AboutAndTerms');
    } else {
      log('error get AboutAndTerms');
    }
    return aboutAndTermsModel!;
  }
}
