import 'package:flutter/material.dart';

class NoTransactionsMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'No Transactions Added Yet!',
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
          height: 200,
          margin: EdgeInsets.all(50),
        )
      ],
    );
  }
}
