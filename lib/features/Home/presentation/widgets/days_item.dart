import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/providers.dart';
import 'package:aquameter/features/Home/Data/departments_model.dart';
import 'package:aquameter/features/Home/presentation/manager/departments_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class DaysItem extends HookConsumerWidget {
  final ValueChanged onChaned;
  DaysItem({Key? key, required this.onChaned}) : super(key: key);

  final AutoDisposeFutureProvider<List<PlanOfWeek>> provider =
      FutureProvider.autoDispose<List<PlanOfWeek>>((ref) async {
    return await ref
        .read(departMentProvider.notifier)
        .assigndepartMent(); //; may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = '', day = '', month = '', dayCompare = '';

    final DepartMentProvider departMents =
        ref.watch(departMentProvider.notifier);
    return ref.watch(provider).when(
          data: (e) {
            final ValueNotifier<List<PlanOfWeek>> selected =
                useState<List<PlanOfWeek>>(e);
            // e[0].selected = true;
            // departMents.changeDate(
            //     dayNum:
            //         departMents.groupedTransactionValues[0]['name'] as String?,
            //     monthNum:
            //         departMents.groupedTransactionValues[0]['day'] as String?,
            //     nameofDay:
            //         departMents.groupedTransactionValues[0]['month'] as String?,
            //     dayCompareNum: departMents.groupedTransactionValues[0]
            //         ['dayCompare'] as String?);

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              primary: false,
              shrinkWrap: true,
              itemCount: e.length,
              itemBuilder: (context, index) {
                return InkWell(
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
                            departMents.groupedTransactionValues[index]['day']
                                as String,
                            style: TextStyle(
                              color: e[index].selected
                                  ? Colors.white
                                  : Colors.black45,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Text(
                          departMents.groupedTransactionValues[index]['name']
                              as String,
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

                        name = departMents.groupedTransactionValues[i]['name']
                            as String;

                        day = departMents.groupedTransactionValues[i]['day']
                            as String;
                        month = departMents.groupedTransactionValues[i]['month']
                            as String;
                        dayCompare = departMents.groupedTransactionValues[i]
                            ['dayCompare'] as String;
                        onChaned(dayCompare);
                        departMents.changeDate(
                            dayNum: day,
                            monthNum: month,
                            nameofDay: name,
                            dayCompareNum: dayCompare);
                      } else {
                        e[i].selected = false;
                      }
                      selected.value = [...e];
                    }
                  },
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
