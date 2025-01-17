import 'package:flutter/material.dart';
import '../../app/constants/theme_constant.dart';


class AppTheme {
  /// Method to get the application's theme.
  static ThemeData getApplicationTheme({bool isDarkMode = false}) {
    return isDarkMode ? _getDarkTheme() : _getLightTheme();
  }

  /// Light Theme
  static ThemeData _getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: ThemeConstant.primaryColor,
      scaffoldBackgroundColor: ThemeConstant.backgroundColor,
      appBarTheme: AppBarTheme(
        color: ThemeConstant.appBarColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: ThemeConstant.primaryFont,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 16,
          color: ThemeConstant.textColor,
          fontFamily: ThemeConstant.primaryFont,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: ThemeConstant.textColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ThemeConstant.textColor,
          fontFamily: ThemeConstant.primaryFont,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ThemeConstant.buttonColor,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeConstant.primaryFont,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelStyle: TextStyle(color: Colors.grey),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
  }

  /// Dark Theme
  static ThemeData _getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: ThemeConstant.darkPrimaryColor,
      scaffoldBackgroundColor: ThemeConstant.darkBackgroundColor,
      appBarTheme: AppBarTheme(
        color: ThemeConstant.darkPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: ThemeConstant.primaryFont,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 16,
          color: ThemeConstant.darkTextColor,
          fontFamily: ThemeConstant.primaryFont,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: ThemeConstant.darkTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ThemeConstant.darkTextColor,
          fontFamily: ThemeConstant.primaryFont,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: ThemeConstant.darkButtonColor,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeConstant.primaryFont,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelStyle: TextStyle(color: Colors.white70),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }
}
