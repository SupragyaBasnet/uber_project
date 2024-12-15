import 'package:flutter/material.dart';
import 'package:uber_project/view/captain/captain_dashboard_screen_view.dart';
import '../user/login_screen_view.dart';
import 'captain_signup_screen_view.dart'; // Import captain signup page

class CaptainLoginScreenView extends StatefulWidget {
  const CaptainLoginScreenView({super.key});

  @override
  _CaptainLoginScreenViewState createState() =>
      _CaptainLoginScreenViewState();
}

class _CaptainLoginScreenViewState extends State<CaptainLoginScreenView> {
  // Controllers for text fields
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Flag to toggle password visibility
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
              // Captain's phone number input
              TextField(
  controller: phonenumberController,
  decoration: const InputDecoration(
    prefixText: '+977 ',
    labelText: 'What’s our Captain’s Phone Number',
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.phone,
  textInputAction: TextInputAction.next,
),
              const SizedBox(height: 16),

              // Password input field with toggle for visibility
              TextField(
                controller: passwordController,
                obscureText: !_isPasswordVisible, // Toggle visibility
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.text, // Alphabet keyboard for password
                textInputAction: TextInputAction.done, // Submit form on enter
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
                  // Show success message in green color
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login Successful'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green, // Green color for success
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
                    // fontSize: screenWidth * 0.05, // Font size based on screen width
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
                  // style: TextStyle(
                  //   fontSize: screenWidth * 0.05, // Font size based on screen width
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
