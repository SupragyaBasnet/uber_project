import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/features/onboarding/presenatation/view/onboarding_screen_view.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  /// Initialize the splash screen logic
  Future<void> init(BuildContext context) async {
    try {
      // Simulate a delay for the splash screen (e.g., 3 seconds)
      await Future.delayed(const Duration(seconds: 3));

      // Navigate to the Onboarding Page
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreenView(), // Navigate to OnboardingScreenView
          ),
        );
      }
    } catch (e) {
      debugPrint('Error during splash initialization: $e');
      // Handle errors if needed (e.g., show a snackbar or log the issue)
    }
  }
}
