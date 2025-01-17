import 'package:flutter/material.dart';

class MySnackbar {
  MySnackbar._(); // Private constructor to prevent instantiation

  /// Shows a custom Snackbar with the provided message and style.
  static void show({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide existing Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  /// Shows a success Snackbar with a default green background.
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      duration: duration,
    );
  }

  /// Shows an error Snackbar with a default red background.
  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      duration: duration,
    );
  }

  /// Shows an info Snackbar with a default blue background.
  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      duration: duration,
    );
  }
}
