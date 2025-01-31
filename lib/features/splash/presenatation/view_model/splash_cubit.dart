import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/user/presenatation/view/user_login_screen_view.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  /// Initialize the splash screen logic
  Future<void> init(BuildContext context) async {
    try {
      await Future.delayed(const Duration(seconds: 3)); // Simulated delay

      // Navigate to User Login Page if mounted
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserLoginScreenView(),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error during splash initialization: $e');
    }
  }
}
