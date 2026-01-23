import 'package:flutter/material.dart';

/// ScaffoldMessenger con SnackBar personalizado
void showCustomSnackBar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Colors.teal,
  Duration duration = const Duration(milliseconds: 400),
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      duration: duration,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
