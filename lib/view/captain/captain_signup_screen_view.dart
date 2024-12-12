import 'package:flutter/material.dart';
import '../user/signup_screen_view.dart'; // Import user signup screen
import 'captain_login_screen_view.dart'; // Import captain login screen

class CaptainSignupScreenView extends StatelessWidget {
  const CaptainSignupScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // TextEditingControllers to manage text inputs
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Go back to the previous screen
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
              // Captain's full name input field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Captain’s Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Phone number input field
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Password input field
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Create account button
              ElevatedButton(
                onPressed: () {
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
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Account Created Successfully'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Navigate to captain login screen after success
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CaptainLoginScreenView(),
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
                  'Create Account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Font size based on screen width
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Navigate to captain login screen
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CaptainLoginScreenView(),
                    ),
                  );
                },
                child: Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: screenWidth * 0.04, // Font size based on screen width
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sign up as passenger button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreenView(), // Navigate to user signup page
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, screenHeight * 0.07), // Dynamic button height
                ),
                child: Text(
                  'Sign up as Passenger',
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
