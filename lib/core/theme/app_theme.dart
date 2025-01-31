import 'package:flutter/material.dart';
import 'light_dark_theme.dart';

class AppTheme {
  static var lightTheme;

  static var darkTheme;

  static ThemeData get light => lightTheme;
  static ThemeData get dark => darkTheme;

  static ThemeMode getThemeMode(bool isDarkMode) {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}
