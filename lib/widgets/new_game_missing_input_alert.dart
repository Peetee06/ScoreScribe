import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MissingInputsAlert extends StatelessWidget {
  const MissingInputsAlert({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const Text('Missing information'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('Missing information'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }
}
