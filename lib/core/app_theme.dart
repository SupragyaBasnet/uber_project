import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Define the primary color scheme
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: Colors.grey[100],

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 4,
      // centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat Regular',
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Typography
    fontFamily: 'Montserrat',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black, // Default button color
        foregroundColor: Colors.white, // Text color
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true, // If you don't want a background color, set this to false
      fillColor: Colors.white, // Ensure this matches your design
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), // Matches the design's border radius
        borderSide: const BorderSide(color: Colors.grey, width: 1.5), // Adjust color and width
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue, // Text color for TextButton
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
