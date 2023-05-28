import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditGameNameAlertDialog extends StatelessWidget {
  const EditGameNameAlertDialog({super.key, required this.onNameChanged});

  final void Function(String name) onNameChanged;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text('Update game name'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                placeholder: 'Game name',
                controller: controller,
                autofocus: true,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: const Text('Save'),
                onPressed: () {
                  onNameChanged(controller.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        : AlertDialog(
            title: const Text('Update game name'),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Game name',
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  onNameChanged(controller.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
  }
}
