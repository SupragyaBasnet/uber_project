import 'package:flutter/material.dart';
import '../captain/captain_login_screen_view.dart';
import '../user/signup_screen_view.dart';
import 'dashboard/dashboard_screen_view.dart';


class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  _LoginScreenViewState createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // To toggle password visibility
  bool _isPasswordHidden = true;

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
                colors: [Colors.grey.shade700, Colors.white60],
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

                    // Phone Number Input Field
                    _buildTextField(
                      controller: _phoneController,
                      labelText: "Phone Number",
                      prefixText: '+977 ',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Password Input Field
                    _buildTextField(
                      controller: _passwordController,
                      labelText: "Password",
                      obscureText: _isPasswordHidden,
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
                    SizedBox(height: screenHeight * 0.03),

                    // Login Button
                    _buildElevatedButton(
                      text: "Login",
                      backgroundColor: Colors.black,
                      onPressed: () {
                        if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
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
                              content: Text('Login Successful'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );

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
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Signup Navigation
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreenView(),
                            ),
                          );
                        },
                        child: const Text(
                          "New here? Create new account",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Captain Login Button
                    _buildElevatedButton(
                      text: "Sign in as Captain",
                      backgroundColor: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CaptainLoginScreenView(),
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
    TextInputAction textInputAction = TextInputAction.done,
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
        textInputAction: textInputAction,
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
        fixedSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}
