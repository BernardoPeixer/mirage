import 'package:flutter/material.dart';

void showSnackBarDefault({
  required BuildContext context,
  required String message,
  bool isError = false,
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 16,
        right: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
