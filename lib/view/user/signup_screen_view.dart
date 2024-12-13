import 'package:flutter/material.dart';
import 'login_screen_view.dart'; // Import the login screen view
import '../captain/captain_signup_screen_view.dart'; // Import captain signup screen view

class SignupScreenView extends StatefulWidget {
  const SignupScreenView({super.key});

  @override
  _SignupScreenViewState createState() => _SignupScreenViewState();
}

class _SignupScreenViewState extends State<SignupScreenView> {
  // Controllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // To toggle password visibility
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    // MediaQuery for dynamic sizing
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
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name input field
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'What’s your Name',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text, // Alphabet keyboard for name
                textInputAction: TextInputAction.next, // Move to next field on enter
              ),
              const SizedBox(height: 16),

              // Phone number input field
              TextField(
  controller: phonenumberController,
  decoration: const InputDecoration(
    prefixText: '+977 ',
    labelText: 'What’s your Phone Number',
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.phone,
  textInputAction: TextInputAction.next,
),
              const SizedBox(height: 16),

              // Password input field with hide/unhide functionality
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'What’s your Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                ),
                obscureText: _isPasswordHidden,
                keyboardType: TextInputType.text, // Alphabet keyboard for password
                textInputAction: TextInputAction.done, // Done action on enter
              ),
              const SizedBox(height: 16),

              // Create account button
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      phonenumberController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Account Created Successfully'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreenView(),
                        ),
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, screenHeight * 0.07),
                ),
                child: Text(
                  'Create account',
                ),
              ),
              const SizedBox(height: 16),

              // Navigate to login screen
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreenView(),
                    ),
                  );
                },
                child: Text(
                  'Already have an account? Login here',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sign up as captain button
              ElevatedButton(
                onPressed: () {
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
                  minimumSize: Size(double.infinity, screenHeight * 0.07),
                ),
                child: Text(
                  'Sign up as Captain',
                 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
