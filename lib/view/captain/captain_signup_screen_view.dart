import 'package:flutter/material.dart';
import '../user/signup_screen_view.dart';
import 'captain_login_screen_view.dart'; // Import captain login screen

class CaptainSignupScreenView extends StatefulWidget {
  const CaptainSignupScreenView({super.key});

  @override
  _CaptainSignupScreenViewState createState() =>
      _CaptainSignupScreenViewState();
}

class _CaptainSignupScreenViewState extends State<CaptainSignupScreenView> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _vehicleColorController = TextEditingController();
  final TextEditingController _vehiclePlateController = TextEditingController();
  final TextEditingController _vehicleCapacityController = TextEditingController();

  // Dropdown value for vehicle type
  String? _selectedVehicle;

  // Flag to toggle password visibility
  bool _isPasswordVisible = false;

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

                    // Name Input
                    _buildTextField(
                      controller: _nameController,
                      labelText: "What’s our Captain’s name",
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: screenHeight * 0.03),

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
                      labelText: "Enter Password",
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

                    // Vehicle Information Section
                    const Text(
                      "Vehicle Information",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Vehicle Color Input
                    _buildTextField(
                      controller: _vehicleColorController,
                      labelText: "Vehicle Color",
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Vehicle Plate Input
                    _buildTextField(
                      controller: _vehiclePlateController,
                      labelText: "Vehicle Plate",
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Vehicle Capacity Input
                    _buildTextField(
                      controller: _vehicleCapacityController,
                      labelText: "Vehicle Capacity",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Vehicle Type Dropdown
                    _buildDropdownField(
                      labelText: "Select Vehicle",
                      value: _selectedVehicle,
                      items: ["Car", "Bike","EV Car"],
                      onChanged: (String? value) {
                        setState(() {
                          _selectedVehicle = value;
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Create Account Button
                    _buildElevatedButton(
                      text: "Create Captain’s account",
                      backgroundColor: Colors.black,
                      onPressed: () {
                        if (_nameController.text.isEmpty ||
                            _phoneNumberController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            _vehicleColorController.text.isEmpty ||
                            _vehiclePlateController.text.isEmpty ||
                            _vehicleCapacityController.text.isEmpty ||
                            _selectedVehicle == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else if (_phoneNumberController.text.length != 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Phone number must be 10 digits'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else if (!_isPasswordStrong(_passwordController.text)) {
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
                              content: Text('Account Created Successfully'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
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
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Already Have an Account Button
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CaptainLoginScreenView(),
                            ),
                          );
                        },
                        child: const Text(
                          "Already have an account? Login here",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Sign Up as Passenger Button
                    _buildElevatedButton(
                      text: "Sign up as Passenger",
                      backgroundColor: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreenView(),
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

  // Helper method to check password strength
  bool _isPasswordStrong(String password) {
    // Password must be at least 8 characters, with uppercase, lowercase, digits, and special characters
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&%])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
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

  /// Helper method to build DropdownField
  Widget _buildDropdownField({
    required String labelText,
    required List<String> items,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
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
