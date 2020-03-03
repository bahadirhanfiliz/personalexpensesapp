import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get weekdaylyGroupedTransactionValues {
    return List.generate(7, (index) {
      var weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      double sumAmount = 0;

      transactions.forEach((transaction) {
        if (transaction.date.day == weekday.day &&
            transaction.date.month == weekday.month &&
            transaction.date.year == weekday.year)
          sumAmount += transaction.amount;
      });
      return {
        'day': DateFormat.E().format(weekday).substring(0, 2),
        'amount': sumAmount,
      };
    }).reversed.toList();
  }

  double get totalWeeklySpending {
    double total = 0;
    for (var item in weekdaylyGroupedTransactionValues) {
      total += item['amount'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(15),
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: weekdaylyGroupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingPctOfTotal: totalWeeklySpending == 0
                    ? 0
                    : ((data['amount'] as double) / totalWeeklySpending),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
