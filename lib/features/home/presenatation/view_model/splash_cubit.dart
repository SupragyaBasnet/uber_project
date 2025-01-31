import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../onboarding/presenatation/view/onboarding_screen_view.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  /// Initialize the splash screen logic
  Future<void> init(BuildContext context) async {
    try {
      await Future.delayed(const Duration(seconds: 3)); // Simulated delay

      // Navigate to Onboarding Page if mounted
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreenView(),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error during splash initialization: $e');
    }
  }
}
