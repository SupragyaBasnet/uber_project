import 'package:flutter/material.dart';
import 'package:uber_project/view/user/signup_screen_view.dart';
import '../captain/captain_login_screen_view.dart';
import 'dashboard_screen_view.dart'; // Import the DashboardPage

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  _LoginScreenViewState createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          padding: EdgeInsets.all(screenWidth * 0.05), // Dynamic padding based on screen size
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Phone number input field
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'What’s your Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Password input field
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Login button
              ElevatedButton(
                onPressed: () {
                  // Check if phone number or password is empty
                  if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
                    // Show error message if phone number or password is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Show success message if both fields are filled
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login Successful'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green,),
                    );

                    // After showing the message, navigate to DashboardPage
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreenView(),
                        ),
                      );
                    });
                  }
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

              // TextButton to navigate to sign-up page
              TextButton(
                onPressed: () {
                  // Navigate to the SignupScreenView
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreenView(),
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

              // Button to navigate to Captain login page
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CaptainLoginScreenView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, screenHeight * 0.07), // Dynamic button height
                ),
                child: Text(
                  'Sign in as Captain',
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
