import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaveNewGameScreenAlertDialog extends StatelessWidget {
  const LeaveNewGameScreenAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const Text('Confirm'),
        content:
            const Text('Your inputs will be lost. Do you want to proceed?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel the action
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(true); // Confirm the action
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('Confirm'),
        content:
            const Text('Your inputs will be lost. Do you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel the action
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Confirm the action
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    }
  }
}
