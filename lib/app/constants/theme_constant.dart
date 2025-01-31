import 'package:flutter/material.dart';

class ThemeConstants {
  // 🔹 Primary Colors
  static const Color primaryColor = Color(0xFF007AFF);
  static const Color secondaryColor = Color(0xFF34C759);
  static const Color accentColor = Color(0xFFFF9500);
  
  // 🔹 Background Colors
  static const Color lightBackgroundColor = Colors.white;
  static const Color darkBackgroundColor = Color(0xFF1C1C1E);

  // 🔹 Text Colors
  static const Color lightTextColor = Colors.black87;
  static const Color darkTextColor = Colors.white;

  // 🔹 Card Colors
  static const Color lightCardColor = Colors.white;
  static const Color darkCardColor = Color(0xFF2C2C2E);

  // 🔹 Error Color
  static const Color errorColor = Color(0xFFFF3B30);

  // 🔹 Light Theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackgroundColor,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
    ),
    cardColor: lightCardColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: lightTextColor),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: lightTextColor),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: lightTextColor),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: lightTextColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: primaryColor)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: Colors.grey[600]),
    ),
  );

  // 🔹 Dark Theme
  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      color: darkBackgroundColor,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
    ),
    cardColor: darkCardColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: darkTextColor),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: darkTextColor),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: darkTextColor),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: primaryColor)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: Colors.grey[500]),
    ),
  );
}
