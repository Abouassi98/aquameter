import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/features/Home/Data/departments_model.dart';
import 'package:aquameter/features/Home/presentation/manager/plan_of_week_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../manager/get_&_delete_clients_create_meeting_&_period_notifier.dart';

class DaysItem extends ConsumerWidget {
  final ValueChanged onChaned;
  DaysItem({
    Key? key,
    required this.onChaned,
  }) : super(key: key);

  final AutoDisposeFutureProvider<List<PlanOfWeek>> provider =
      FutureProvider.autoDispose<List<PlanOfWeek>>((ref) async {
    return await ref
        .read(departMentProvider.notifier)
        .assigndepartMent(); //; may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GetAndDeleteClientsCreateMettingAndPeriodNotifier getHomeClients =
        ref.read(getClientsNotifier.notifier);
    String dayCompare = '';
    final PlanOfWeekNotifier departMents =
        ref.watch(departMentProvider.notifier);
    final StateProvider<List<PlanOfWeek>> selectedProvider =
        StateProvider<List<PlanOfWeek>>(((ref) => departMents.departments));
    List<PlanOfWeek> selected = ref.watch(selectedProvider);
    return ref.watch(provider).when(
          data: (e) {
            if (getHomeClients.isInit == false) {
              Future.delayed(const Duration(seconds: 0), () {
                e[0].selected = true;
                dayCompare = departMents.groupedTransactionValues[0]
                    ['dayCompare'] as String;
                onChaned(dayCompare);

                ref.read(selectedProvider.state).state = [...e];
                getHomeClients.isInit = true;
              });
            }
            return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            backgroundColor: selected[index].selected
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
                                color: selected[index].selected
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

                          dayCompare = departMents.groupedTransactionValues[i]
                              ['dayCompare'] as String;
                          onChaned(dayCompare);
                        } else {
                          e[i].selected = false;
                        }
                        ref.read(selectedProvider.state).state = [...e];
                      }
                    },
                  );
                });
          },
          error: (e, o) {
            debugPrint(e.toString());
            debugPrint(o.toString());
            return const Text('error');
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
