import 'package:flutter/material.dart';
import 'login_screen_view.dart'; // Import your Login Screen

class OnboardingScreenView extends StatefulWidget {
  const OnboardingScreenView({super.key});

  @override
  _OnboardingScreenViewState createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<OnboardingScreenView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onNext() {
    // Navigate to the login screen when the next button is pressed
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreenView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Uber'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                OnboardingPage(
                  imagePath: 'assets/images/image1.jpg', // Correct path to the first image
                  title: 'Your Ride, Your Comfort',
                  description:
                      'Get where you need to be with style and ease. Our premium vehicles and personalized service '
                      'ensure every journey feels like a first-class experience. No matter the destination, your comfort '
                      'and convenience are our priorities.',
                ),
                OnboardingPage(
                  imagePath: 'assets/images/image2.png', // Correct path to the second image
                  title: 'Track Your Ride in Real-Time',
                  description:
                      'Stay in control and never miss a beat. With our cutting-edge GPS tracking system, you can see '
                      'exactly where your ride is, estimate arrival times, and make informed decisions. Your journey, '
                      'your timeline, every time.',
                ),
                OnboardingPage(
                  imagePath: 'assets/images/image3.png', // Correct path to the third image
                  title: 'Reliable Drivers, Safe Journey',
                  description:
                      'Safety is more than a promise; it’s a guarantee. Our drivers undergo rigorous background checks '
                      'and continuous training to ensure every trip is secure. Whether it’s a short ride or a long journey, '
                      'we deliver peace of mind, one mile at a time.',
                  isLastPage: true, // To identify the last page
                ),
              ],
            ),
          ),
          // Page navigation arrows
          Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    if (_currentPage != 0)
      IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.green),
        onPressed: () {
          _pageController.previousPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      )
    else
      SizedBox(width: 48), // Placeholder width for the back button

    Expanded(
      child: Center(
        child: Text(
          '${_currentPage + 1} of 3',
          style: TextStyle(color: Colors.green, fontSize: 16),
        ),
      ),
    ),

    if (_currentPage != 2)
      IconButton(
        icon: Icon(Icons.arrow_forward, color: Colors.green),
        onPressed: () {
          _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      )
    else
      IconButton(
        icon: Icon(Icons.arrow_forward, color: Colors.green),
        onPressed: _onNext,
      ),
  ],
),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool isLastPage;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5, // Adjust height based on screen size
            width: double.infinity,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Updated color to grey
              ),
            ),
          ),
          const SizedBox(height: 20), // Add spacing at the bottom for better readability
        ],
      ),
    );
  }
}
