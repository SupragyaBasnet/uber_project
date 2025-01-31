import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/app/di/di.dart';
import 'package:uber_mobile_app_project/core/theme/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ✅ Import HiveService
import 'core/network/hive_service.dart';


// ✅ Import Screens
import 'features/auth/captain/presenatation/view/captain_login_view.dart';
import 'features/auth/captain/presenatation/view_model/captain_login.bloc.dart';
import 'features/auth/captain/presenatation/view_model/captain_signup_bloc.dart';
import 'features/auth/user/presenatation/view/user_login_screen_view.dart';
import 'features/auth/user/presenatation/view_model/user_login_bloc.dart';
import 'features/auth/user/presenatation/view_model/user_signup_bloc.dart';
import 'features/captain_home/presenatation/view/splash_view.dart';
import 'package:uber_mobile_app_project/features/auth/user/presenatation/view/user_signup_screen_view.dart';

// import 'features/onboarding/presenatation/view/onboarding_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Setup Dependency Injection
  await setupDI();

  // ✅ Initialize Hive (Local Storage)
  await Hive.initFlutter();
  await HiveService().openBoxes(); // ✅ Fixed: openBoxes method

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<UserLoginBloc>()), //
        BlocProvider(create: (_) => serviceLocator<UserSignupBloc>()), //
        BlocProvider(create: (_) => serviceLocator<CaptainLoginBloc>()), //
        BlocProvider(create: (_) => serviceLocator<CaptainSignupBloc>()), //
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EasyGo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // Adapts based on system settings
        home: const SplashView(),
        routes: {
          // '/onboarding': (context) => const OnboardingScreenView(),
          '/user-login': (context) => UserLoginScreenView(),
          '/captain-login': (context) => const CaptainLoginScreenView(),
          '/signup': (context) => const UserSignupScreenView(),
        },
      ),
    );
  }
}
