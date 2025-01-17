import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/core/theme/app_theme.dart';
import 'package:uber_mobile_app_project/features/splash/presenatation/view/splash_view.dart';
import 'package:uber_mobile_app_project/features/onboarding/presenatation/view/onboarding_screen_view.dart';
import 'package:uber_mobile_app_project/features/splash/presenatation/view_model/splash_cubit.dart';
import 'package:uber_mobile_app_project/features/onboarding/presenatation/view_model/onboarding_cubit.dart';
import 'package:uber_mobile_app_project/features/auth/user/presenatation/view/user_login_screen_view.dart';
import 'package:uber_mobile_app_project/features/auth/user/presenatation/view/user_signup_screen_view.dart';
import 'package:uber_mobile_app_project/features/auth/user/presenatation/view/captain_signup_screen_view.dart';

import '../features/auth/user/presenatation/view/captain_login_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SplashCubit(), // Splash screen logic
        ),
        BlocProvider(
          create: (_) => OnboardingCubit(), // Onboarding logic
        ),
        // Add other Blocs or Cubits as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EasyGo',
        theme: AppTheme.getApplicationTheme(isDarkMode: false), // App theme
        initialRoute: '/', // Starting route
        routes: {
          '/': (context) => const SplashView(), // Splash screen
          '/onboarding': (context) => const OnboardingScreenView(), // Onboarding screen
          '/login': (context) => UserLoginScreenView(), // User login screen
          '/signup': (context) => UserSignupScreenView(), // User signup screen
          '/captain-login': (context) => CaptainLoginScreenView(), // Captain login screen
          '/captain-signup': (context) => CaptainSignupScreenView(), // Captain signup screen
        },
      ),
    );
  }
}
