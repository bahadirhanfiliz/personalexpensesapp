import 'package:flutter/material.dart';

import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';
import 'no_transactions_message.dart';
import 'transaction_list_entry.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: transactions.map((transaction) {
    //     return TransactionListEntry(transaction);
    //   }).toList(),
    // );

    return transactions.isEmpty
        ? NoTransactionsMessage()
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              // return TransactionListEntry(transactions[index]);
              return TransactionItem(transaction: transactions[index], deleteTransaction: deleteTransaction);
            });
  }
}


