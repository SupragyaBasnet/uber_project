import 'package:flutter/material.dart';

class MySnackbar {
  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    int durationInSeconds = 3,
    SnackBarAction? action,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: durationInSeconds),
      action: action,
      behavior: SnackBarBehavior.floating, // Floating snackbar style
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    int durationInSeconds = 3,
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      durationInSeconds: durationInSeconds,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    int durationInSeconds = 3,
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      durationInSeconds: durationInSeconds,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    int durationInSeconds = 3,
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      durationInSeconds: durationInSeconds,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    int durationInSeconds = 3,
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      durationInSeconds: durationInSeconds,
    );
  }
}
