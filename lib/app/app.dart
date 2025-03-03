import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uber_mobile_app_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:uber_mobile_app_project/features/auth/captain/presenatation/view/captain_login_screen.dart';
import 'package:uber_mobile_app_project/features/auth/captain/presenatation/view/captain_signup_screen.dart';
import 'package:uber_mobile_app_project/features/auth/captain/presenatation/view_model/captain_signup_bloc.dart';


import '../core/theme/app_theme.dart';
import '../features/auth/captain/presenatation/view_model/captain_login.bloc.dart';
import '../features/auth/forgot_password/presenatation/view/forgot_password__screen.dart';
import '../features/auth/user/presenatation/view/user_login_screen.dart';
import '../features/auth/user/presenatation/view/user_signup_screen.dart';

import '../features/captain_home/presenatation/view/captain_home.dart';
import '../features/captain_home/presenatation/view_model/captain_home_bloc.dart';
import '../features/home/presenatation/view/splash_view.dart';
import '../features/home/presenatation/view_model/splash_cubit.dart';
import '../features/onboarding/presenatation/view/onboarding_screen_view.dart';
import '../features/onboarding/presenatation/view_model/onboarding_cubit.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(); // Initialize DI
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SplashCubit>()),
        BlocProvider(create: (context) => getIt<OnboardingCubit>()),
        BlocProvider(create: (context) => getIt<CaptainLoginBloc>()),
        BlocProvider(create: (context) => getIt<CaptainSignupBloc>()),
        BlocProvider(create: (context) => getIt<CaptainLoginBloc>()),
        BlocProvider(create: (context) => getIt<CaptainSignupBloc>()),
        // BlocProvider(create: (context) => getIt<HomeBloc>()),
        BlocProvider(create: (context) => getIt<CaptainHomeBloc>()),
        // BlocProvider(create: (context) => getIt<RideBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme, //  Corrected theme
        darkTheme: AppTheme.darkTheme, //  Support dark mode
        themeMode: ThemeMode.system, // Using theme from theme_constants.dart
        initialRoute: '/',
        routes: {
          '/': (context) => SplashView(),
          '/onboarding': (context) => OnboardingScreenView(),
          '/login': (context) => UserLoginScreen(),
          '/signup': (context) => UserSignupScreen(),
          '/captain-login': (context) => CaptainLoginScreen(),
          '/captain-signup': (context) => CaptainSignupScreen(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
          // '/home': (context) => HomeScren(),
          '/captain-home': (context) => CaptainHome(),
        },
      ),
    );
  }
}
