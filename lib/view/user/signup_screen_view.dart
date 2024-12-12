import 'package:flutter/material.dart';
import 'login_screen_view.dart'; // Import the login screen view
import '../captain/captain_signup_screen_view.dart'; // Import captain signup screen view

class SignupScreenView extends StatelessWidget {
  const SignupScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // TextEditingControllers to get the input text
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
              // Name input field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'What’s your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              
              // Phone number input field
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'What’s your Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              
              // Password input field
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'What’s your Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              
              // Create account button
              ElevatedButton(
                onPressed: () {
                  // Check if any field is empty
                  if (nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    // Show error message if any field is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please fill in all fields'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Show success message if all fields are filled
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Account Created Successfully'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // After showing the message, navigate to the login screen
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreenView(), // Navigate to login screen after account creation
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
                  'Create account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Font size based on screen width
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Navigate to login screen
              TextButton(
                onPressed: () {
                  // Navigate to the login screen when already have an account
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreenView(), // Navigate to login screen
                    ),
                  );
                },
                child: Text(
                  'Already have an account? Login here',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: screenWidth * 0.04, // Font size based on screen width
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Sign up as captain button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Captain Signup screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CaptainSignupScreenView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, screenHeight * 0.07), // Dynamic button height
                ),
                child: Text(
                  'Sign up as Captain',
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
