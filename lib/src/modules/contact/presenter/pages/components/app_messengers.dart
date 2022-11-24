import 'package:flutter/material.dart';

class AppMessengers {
  final BuildContext context;
  final String message;

  AppMessengers(this.context, this.message);

  void showSnackBar({required SnackBarType type}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type == SnackBarType.success
            ? Colors.green.shade800
            : Colors.red.shade800,
        content: Text(message, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

enum SnackBarType { success, error }
