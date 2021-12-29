import 'package:aquameter/features/Home/Data/departments_model.dart';
import 'package:aquameter/features/Home/Data/transaction_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class DepartMentProvider extends StateNotifier<void> {
  DepartMentProvider(void state) : super(state);
  int? id;
  String? name, month, day;
  bool selected = false;
  List<Transaction> recentTransactions = [];
  List<Departments> departments = [];

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
        'name': DateFormat.EEEE(
          'ar',
        ).format(weekDay).toString(),
        'id': index,
      };
    }).toList();
  }

  Future<List<Departments>> assigndepartMent() async {
    if (departments.length < 7) {
      await Future.delayed(const Duration(seconds: 1), () {
        for (var element in groupedTransactionValues) {
          departments.add(Departments(
              id: element['id'] as int?,
              name: element['day'] as String?,
              month: element['month'] as String?,
              selected: false,
              day: element['name'] as String?));
        }
        debugPrint('${departments.length}');
      });
    }
    return departments;
  }

  void changeDate({String? nameofDay, String? dayNum, String? monthNum}) {
    name = nameofDay;
    day = dayNum;
    month = monthNum;
  }
}
