import 'package:flutter/material.dart';
import 'package:uber_project/view/captain/captain_dashboard_screen_view.dart';
import '../user/login_screen_view.dart';
import 'captain_signup_screen_view.dart'; // Import captain signup page


class CaptainLoginScreenView extends StatelessWidget {
  const CaptainLoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Uber'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.05), // Dynamic padding based on screen width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Captain's phone number input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Captain’s Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              
              // Password input field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              
              // Login button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the dashboard page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CaptainDashboardScreenView(), // Navigate to the DashboardPage
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, screenHeight * 0.07), // Dynamic button height
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Font size based on screen width
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Navigate to captain signup screen
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CaptainSignupScreenView(),
                    ),
                  );
                },
                child: Text(
                  'New here? Create new account',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: screenWidth * 0.04, // Font size based on screen width
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Navigate to user login screen (for passenger)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreenView(), // Navigate to the user login page
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, screenHeight * 0.07), // Dynamic button height
                ),
                child: Text(
                  'Sign in as Passenger',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Font size based on screen width
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
