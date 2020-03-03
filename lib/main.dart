import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/adaptive_app_bar.dart';

import 'package:personal_expenses/widgets/transaction_list.dart';
import 'package:personal_expenses/widgets/transaction_user_input.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
        ),
        textTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 1,
    //   title: "Demo Transaction 1",
    //   amount: 69.90,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 2,
    //   title: "Demo Transaction 2",
    //   amount: 19.22,
    //   date: DateTime.now(),
    // ),
  ];

final PreferredSizeWidget appBar = adaptiveAppBar();

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void addTransactionToList(Transaction t) {
    setState(() {
      _transactions.add(t);
    });
  }

  void deleteTransactionFromList(Transaction t) {
    setState(() {
      _transactions.remove(t);
    });
  }

  void startAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            child: TransactionUserInput(addTransactionToList),
            height: 625,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height - MediaQuery.of(context).padding.top) *
                  0.3,
              child: Container(
                  width: double.infinity, child: Chart(_recentTransactions)),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height - MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(
                transactions: _transactions,
                deleteTransaction: deleteTransactionFromList,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddTransaction(context);
        },
        tooltip: 'Add Transaction',
      ),
    );
  }
}
