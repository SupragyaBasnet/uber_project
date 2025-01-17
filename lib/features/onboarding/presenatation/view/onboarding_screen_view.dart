import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/app/di/di.dart';

import '../../../auth/user/presenatation/view/user_login_screen_view.dart';
import 'onboarding_page.dart'; // Import the OnboardingPage widget
import '../view_model/onboarding_cubit.dart'; // Import OnboardingCubit


class OnboardingScreenView extends StatefulWidget {
  const OnboardingScreenView({Key? key}) : super(key: key);

  @override
  _OnboardingScreenViewState createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<OnboardingScreenView> {
  final PageController _pageController = PageController();

  void _onNext() {
    final cubit = context.read<OnboardingCubit>();
    if (cubit.state == 2) {
      // Navigate to the UserLoginScreenView after onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserLoginScreenView(),
        ),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      cubit.updatePage(cubit.state + 1);
    }
  }

  void _onBack() {
    final cubit = context.read<OnboardingCubit>();
    if (cubit.state > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      cubit.updatePage(cubit.state - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<OnboardingCubit>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            'EasyGo',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: BlocBuilder<OnboardingCubit, int>(
          builder: (context, currentPage) {
            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) =>
                        context.read<OnboardingCubit>().updatePage(page),
                    children: const [
                      OnboardingPage(
                        imagePath: 'assets/images/image1.webp',
                        title: 'Your Ride, Your Comfort',
                        description:
                            'Get where you need to be with style and ease. Our premium vehicles ensure every journey feels like a first-class experience.',
                      ),
                      OnboardingPage(
                        imagePath: 'assets/images/image2.png',
                        title: 'Track Your Ride in Real-Time',
                        description:
                            'Stay in control with our GPS tracking system. Know exactly where your ride is and plan your timeline efficiently.',
                      ),
                      OnboardingPage(
                        imagePath: 'assets/images/image3.jpg',
                        title: 'Reliable Drivers, Safe Journey',
                        description:
                            'Our drivers are professionally trained to ensure every trip is secure. Enjoy peace of mind, one ride at a time.',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: currentPage == 0
                          ? Colors.grey // Disabled appearance
                          : Colors.black,
                      onPressed: currentPage == 0 ? null : _onBack,
                    ),

                    // Page Indicator
                    Expanded(
                      child: Center(
                        child: Text(
                          '${currentPage + 1} of 3',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(

                              ),
                        ),
                      ),
                    ),

                    // Forward Button
                    IconButton(
                      icon: Icon(
                        currentPage == 3 ? Icons.check : Icons.arrow_forward,
                        color: Colors.black,
                      ),
                      onPressed: _onNext,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
