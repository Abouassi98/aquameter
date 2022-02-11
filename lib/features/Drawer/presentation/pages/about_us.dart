import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/features/Drawer/Data/about_terms_model.dart';
import 'package:aquameter/features/Drawer/manager/about_terms_notifier.dart';
import 'package:aquameter/features/Drawer/presentation/widgets/about_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/widgets/app_loader.dart';

class AboutAndTerms extends HookConsumerWidget {
  final String title;
  bool isAbout;
   AboutAndTerms({
    Key? key,
    required this.title,
    required this.isAbout,
  }) : super(key: key);

  final FutureProvider<AboutAndTermsModel> provider =
  FutureProvider<AboutAndTermsModel>((ref) async {
    return await ref
        .read(getAboutAndTermsNotifier.notifier)
        .getAboutAndTerms(); //; may cause `provider` to rebuild
  });
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final GetAboutAndTermsNotifier aboutAndTermsNotifier = ref.read(
      getAboutAndTermsNotifier.notifier,
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            title,
            style: MainTheme.headingTextStyle,
          ),
          centerTitle: true,
        ),
        body:  ref.watch(provider).when(
          loading: () => const AppLoader(),
          error: (e, o) {
            debugPrint(e.toString());
            debugPrint(o.toString());
            return const Text('error');
          },
          data:(e)=> Padding(
              padding: const EdgeInsets.all(20), child:AboutItem(text:isAbout?  aboutAndTermsNotifier.aboutAndTermsModel!.data!.about:aboutAndTermsNotifier.aboutAndTermsModel!.data!.termsConditions)),
        ),
      ),
    );
  }
}
