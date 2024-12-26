import 'package:flutter/material.dart';
import '../user/login_screen_view.dart';
import '../user/forgot_password_view.dart'; // Adjusted import for ForgotPasswordView
import 'captain_signup_screen_view.dart'; // Import captain signup page
import 'captain_dashboard_screen_view.dart'; // Import captain dashboard screen

class CaptainLoginScreenView extends StatefulWidget {
  const CaptainLoginScreenView({super.key});

  @override
  _CaptainLoginScreenViewState createState() =>
      _CaptainLoginScreenViewState();
}

class _CaptainLoginScreenViewState extends State<CaptainLoginScreenView> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Helper method to check if password is strong
  bool _isPasswordStrong(String password) {
    // Password must be at least 8 characters, with uppercase, lowercase, digits, and special characters
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade700, Colors.white30],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo Section
                    Center(
                      child: Container(
                        width: screenHeight * 0.2,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    // Phone Number Input
                    _buildTextField(
                      controller: _phoneNumberController,
                      labelText: "What’s our Captain’s Phone Number",
                      prefixText: '+977 ',
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Password Input
                    _buildTextField(
                      controller: _passwordController,
                      labelText: "Password",
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Forgot Password Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordView(
                                  initialPhoneNumber: _phoneNumberController.text,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),

                    // Login Button
                    _buildElevatedButton(
                      text: "Login",
                      backgroundColor: Colors.black,
                      onPressed: () {
                        // Phone number validation (must be 10 digits)
                        if (_phoneNumberController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } 
                        else if (_phoneNumberController.text.length != 10) {  // *** Phone Number Validation ***
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Phone number must be 10 digits'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        else if (!_isPasswordStrong(_passwordController.text)) {  // *** Password Strength Validation ***
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password must be strong'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login Successful'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CaptainDashboardScreenView(),
                              ),
                            );
                          });
                        }
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Navigate to Signup Button
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CaptainSignupScreenView(),
                            ),
                          );
                        },
                        child: const Text(
                          "New here? Create new account",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Sign In as Passenger Button
                    _buildElevatedButton(
                      text: "Sign in as Passenger",
                      backgroundColor: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreenView(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Helper method to build TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? prefixText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixText: prefixText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          suffixIcon: suffixIcon,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }

  /// Helper method to build ElevatedButton
  Widget _buildElevatedButton({
    required String text,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        fixedSize: const Size(double.infinity, 50), // Fixed button size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text),
    );
  }
}
