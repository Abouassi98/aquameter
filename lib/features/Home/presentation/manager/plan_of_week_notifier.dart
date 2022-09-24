import 'package:aquameter/features/Home/Data/departments_model.dart';
import 'package:aquameter/features/Home/Data/transaction_model.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final AutoDisposeStateNotifierProvider<PlanOfWeekNotifier, Object?>
    departMentProvider = StateNotifierProvider.autoDispose(
  (ref) => PlanOfWeekNotifier(null),
);

class PlanOfWeekNotifier extends StateNotifier<void> {
  PlanOfWeekNotifier(void state) : super(state);
  int? id;
  String name = '', month = '', day = '', dayCompare = '';
  bool selected = false;
  final List<Transaction> _userTransactions = [];
  List<PlanOfWeek> departments = [];

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().add(
        Duration(days: index),
      );

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {}
      }

      return {
        'month': weekDay.toString().substring(6, 7),
        'day': weekDay.toString().substring(8, 10),
        'dayCompare': weekDay.toString().substring(0, 10),
        'name': DateFormat.EEEE(
          'ar',
        ).format(weekDay).toString(),
        'id': index,
      };
    }).toList();
  }

  Future<List<PlanOfWeek>> assigndepartMent() async {
 
    if (departments.length < 7) {
      await Future.delayed(const Duration(seconds: 1), () {
        for (var element in groupedTransactionValues) {
          departments.add(PlanOfWeek(
              dayCompare: element['dayCompare'] as String?,
              id: element['id'] as int?,
              name: element['day'] as String?,
              month: element['month'] as String?,
              selected: false,
              day: element['name'] as String?));
        }
      });
    }
    return departments;
  }
}
