import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/app/di/di.dart';

import '../core/theme/light_dark_theme.dart';
import '../features/auth/captain/presenatation/view/captain_login_view.dart';
import '../features/auth/captain/presenatation/view/captain_signup_screen_view.dart';
import '../features/auth/captain/presenatation/view_model/captain_login.bloc.dart';
import '../features/auth/forgot_password/presenatation/view/forgot_password__screen.dart';
import '../features/auth/user/presenatation/view/user_login_screen_view.dart';
import '../features/auth/user/presenatation/view/user_signup_screen_view.dart';
import '../features/captain_home/presenatation/view/splash_view.dart';
import '../features/onboarding/presenatation/view/onboarding_screen_view.dart';
import '../features/auth/user/presenatation/view_model/user_login_bloc.dart';
import '../features/auth/user/presenatation/view_model/user_signup_bloc.dart';
import '../features/auth/captain/presenatation/view_model/captain_signup_bloc.dart';
import '../features/auth/forgot_password/presenatation/view_model/forgot_password_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  await setupDI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<UserLoginBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserSignupBloc>()),
        BlocProvider(create: (_) => serviceLocator<CaptainLoginBloc>()),
        BlocProvider(create: (_) => serviceLocator<CaptainSignupBloc>()),
        BlocProvider(create: (_) => serviceLocator<ForgotPasswordBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EasyGo Ride App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          // Start Page
          '/': (context) => const SplashView(),

          // Onboarding
          '/onboarding': (context) => const OnboardingScreenView(),

          // User Authentication
          '/login': (context) => UserLoginScreenView(),
          '/signup': (context) => const UserSignupScreenView(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),

          // Captain Authentication
          '/captain-login': (context) => const CaptainLoginScreenView(),
          '/captain-signup': (context) => const CaptainSignupScreenView(),
        },
      ),
    );
  }
}
