import 'package:flutter/material.dart';
import 'core/app_theme.dart'; // Import the theme file
import 'view/user/onboarding_screen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(), // Use the imported theme
      home: const OnboardingScreenView(),
    );
  }
}
