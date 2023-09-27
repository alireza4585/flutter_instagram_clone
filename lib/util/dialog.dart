import 'package:flutter/material.dart';

Future<void> dialogBuilder(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
