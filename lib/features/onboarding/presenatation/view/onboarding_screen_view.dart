import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; //



import '../../../../app/di/di.dart';
import 'onboarding_page.dart';
import '../view_model/onboarding_cubit.dart';

class OnboardingScreenView extends StatefulWidget {
  const OnboardingScreenView({Key? key}) : super(key: key);

  @override
  _OnboardingScreenViewState createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<OnboardingScreenView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(), // ✅ Fix serviceLocator error
      child: BlocListener<OnboardingCubit, int>(
        listener: (context, currentPage) {
          if (currentPage == 3) {
            Navigator.pushReplacementNamed(context, "/user-login");
          }
        },
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

                  // ✅ Page Indicator (Fixed)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect( // ✅ Fixed import
                        activeDotColor: Theme.of(context).primaryColor,
                        dotColor: Colors.grey.shade400,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                  ),

                  // ✅ Navigation Buttons (Fixed)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: currentPage == 0 ? Colors.grey : Colors.black,
                        onPressed: currentPage == 0
                            ? null
                            : () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                          context.read<OnboardingCubit>().updatePage(currentPage - 1);
                        },
                      ),

                      // Forward Button
                      IconButton(
                        icon: Icon(
                          currentPage == 2 ? Icons.check : Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          if (currentPage < 2) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                            context.read<OnboardingCubit>().updatePage(currentPage + 1);
                          } else {
                            // ✅ Ensure onboarding completes and triggers navigation
                            context.read<OnboardingCubit>().updatePage(3);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
