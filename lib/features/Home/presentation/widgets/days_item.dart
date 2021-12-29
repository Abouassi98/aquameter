import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/features/Home/Data/departments_model.dart';
import 'package:aquameter/features/Home/presentation/manager/departments_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DaysItem extends HookConsumerWidget {
  DaysItem({Key? key}) : super(key: key);

  final AutoDisposeFutureProvider<List<Departments>> provider =
      FutureProvider.autoDispose<List<Departments>>((ref) async {
    return await ref
        .read(departMentProvider.notifier)
        .assigndepartMent(); //; may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? name, day, month;

    final DepartMentProvider departMents =
        ref.watch(departMentProvider.notifier);

    return ref.watch(provider).when(
          data: (e) {
            final ValueNotifier<List<Departments>> selected =
                useState<List<Departments>>(e);
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              primary: false,
              shrinkWrap: true,
              itemCount: e.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 400),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 400),
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                        child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: selected.value[index].selected
                                  ? Colors.red
                                  : Colors.grey[400],
                              child: Text(
                                departMents.groupedTransactionValues[index]
                                    ['day'] as String,
                                style: TextStyle(
                                  color: e[index].selected
                                      ? Colors.white
                                      : Colors.black45,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Text(
                              departMents.groupedTransactionValues[index]
                                  ['name'] as String,
                              style: MainTheme.subTextStyle.copyWith(
                                  color: selected.value[index].selected
                                      ? Colors.red
                                      : Colors.grey[400]),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        for (int i = 0; i < e.length; i++) {
                          if (i == index) {
                            e[i].selected = true;

                            name = departMents.groupedTransactionValues[i]
                                ['name'] as String?;

                            day = departMents.groupedTransactionValues[i]['day']
                                as String?;
                            month = departMents.groupedTransactionValues[i]
                                ['month'] as String?;

                            departMents.changeDate(
                                dayNum: day, monthNum: month, nameofDay: name);
                          } else {
                            e[i].selected = false;
                          }
                          selected.value = [...e];
                        }
                      },
                    )),
                  ),
                );
              },
            );
          },
          error: (e, o) {
            debugPrint(e.toString());
            debugPrint(o.toString());
            return const Text('error');
          },
          loading: () => SpinKitFadingCircle(
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        );
  }
}
