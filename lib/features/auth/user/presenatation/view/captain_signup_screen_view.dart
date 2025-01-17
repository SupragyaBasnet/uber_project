import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/di/di.dart';
import '../../../../../app/widgets/custom_button.dart';
import '../../../../../app/widgets/custom_text_field.dart';
import '../view_model/user_login_bloc.dart';
import '../view_model/user_login_event.dart';
import '../view_model/user_login_state.dart';

class CaptainSignupScreenView extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController vehicleColorController = TextEditingController();
  final TextEditingController vehiclePlateController = TextEditingController();
  final TextEditingController vehicleCapacityController = TextEditingController();
  String vehicleType = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<UserLoginBloc>(), // Provide UserLoginBloc locally
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EasyGo - Captain Signup'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20),

                const Text(
                  "Create Account as Captain",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // First and Last Name Input
                CustomTextField(
                  controller: firstNameController,
                  hintText: 'First Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                ),
                const SizedBox(height: 16),

                // Phone Number Input
                CustomTextField(
                  controller: phoneController,
                  hintText: 'Phone Number (+977XXXXXXXXXX)',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                // Password Input
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // Vehicle Information
                const Text(
                  "Vehicle Information",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: vehicleColorController,
                  hintText: 'Vehicle Color',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: vehiclePlateController,
                  hintText: 'Vehicle Plate',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: vehicleCapacityController,
                  hintText: 'Vehicle Capacity',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: vehicleType.isNotEmpty ? vehicleType : null,
                  onChanged: (value) {
                    vehicleType = value!;
                  },
                  items: const [
                    DropdownMenuItem(value: 'car', child: Text('Car')),
                    DropdownMenuItem(value: 'motorcycle', child: Text('Motorcycle')),
                    DropdownMenuItem(value: 'auto', child: Text('Auto')),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Vehicle Type',
                  ),
                ),
                const SizedBox(height: 20),

                // Navigate to Login
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/captain-login');
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 10),

                // Create Account Button
                CustomButton(
                  text: 'Create Account',
                  onPressed: () {
                    String phone = phoneController.text.trim();
                    final String password = passwordController.text.trim();
                    final String firstName = firstNameController.text.trim();
                    final String lastName = lastNameController.text.trim();
                    final String vehicleColor = vehicleColorController.text.trim();
                    final String vehiclePlate = vehiclePlateController.text.trim();
                    final String vehicleCapacity = vehicleCapacityController.text.trim();

                    // Input Validation
                    if (firstName.isEmpty ||
                        lastName.isEmpty ||
                        phone.isEmpty ||
                        password.isEmpty ||
                        vehicleColor.isEmpty ||
                        vehiclePlate.isEmpty ||
                        vehicleCapacity.isEmpty ||
                        vehicleType.isEmpty) {
                      _showErrorSnackBar(context, 'All fields are required.');
                      return;
                    }

                    if (!phone.startsWith('+977') || !RegExp(r'^\+977\d{10}$').hasMatch(phone)) {
                      _showErrorSnackBar(
                        context,
                        'Phone number must start with +977 and contain exactly 10 digits.',
                      );
                      return;
                    }

                    if (password.length < 8 ||
                        !RegExp(r'[A-Z]').hasMatch(password) ||
                        !RegExp(r'[a-z]').hasMatch(password) ||
                        !RegExp(r'[0-9]').hasMatch(password) ||
                        !RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
                      _showErrorSnackBar(
                        context,
                        'Password must be at least 8 characters long, include uppercase, lowercase, a number, and a special character.',
                      );
                      return;
                    }

                    // Trigger the event
                    context.read<UserLoginBloc>().add(
                      UserLoginSubmit(
                        phoneNumber: phone,
                        password: password,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),

                // Sign Up as Passenger
                CustomButton(
                  text: 'Sign up as Passenger',
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
