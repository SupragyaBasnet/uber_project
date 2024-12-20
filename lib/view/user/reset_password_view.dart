import 'package:flutter/material.dart';

class SetPasswordView extends StatefulWidget {
  final String phoneNumber;

  const SetPasswordView({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _SetPasswordViewState createState() => _SetPasswordViewState();
}

class _SetPasswordViewState extends State<SetPasswordView> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordHidden = true;
  String _errorMessage = "";

  void _validateAndSubmit() {
    _errorMessage = "";
    
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showSnackbar("All fields are required.", Colors.red);
      return;
    }

    if (newPassword.length < 8 ||
        !RegExp(r'(?=.*[!@#\\$&*~%])').hasMatch(newPassword)) {
      _showSnackbar(
        "Password must be at least 8 characters long and include a special character.",
        Colors.red,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackbar("Passwords do not match.", Colors.red);
      return;
    }

    _showSnackbar("Password reset successfully!", Colors.green);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _showSnackbar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade700, Colors.white60],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Set New Password",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Set a new password for your account",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // New Password Field
                  Container(
                    width: screenWidth * 0.9,
                    height: screenWidth * 0.15,
                    child: TextField(
                      controller: _newPasswordController,
                      obscureText: _isPasswordHidden,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
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
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password Field
                  Container(
                    width: screenWidth * 0.9,
                    height: screenWidth * 0.15,
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: _isPasswordHidden,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
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
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Set Password Button
                  ElevatedButton(
                    onPressed: _validateAndSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(screenWidth * 0.9, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Set Password",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
