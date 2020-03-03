import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget adaptiveAppBar() {
  return Platform.isIOS
      ? CupertinoNavigationBar(
          middle: Text(
            'Personal Expenses',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
        )
      : AppBar(
          title: Text('Personal Expenses'),
        );
}
