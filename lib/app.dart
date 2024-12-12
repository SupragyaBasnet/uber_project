import 'package:flutter/material.dart';
// import 'package:uber_project/view/admin/admin_login_screen_view.dart';
import 'package:uber_project/view/user/onboarding_screen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingScreenView()
        // home:AdminLoginScreenView()
        // home: LoginScreenView()
  );}
}
