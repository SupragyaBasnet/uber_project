import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/widgets/custom_button.dart';
import '../../../../../app/widgets/custom_text_field.dart';
import '../../../../../app/di/di.dart'; // Import your DI setup
import '../view_model/user_signup_bloc.dart';
import '../view_model/user_signup_event.dart';
import '../view_model/user_signup_state.dart';

class UserSignupScreenView extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<UserSignupBloc>(), // Use DI to provide UserSignupBloc
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EasyGo - Signup'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<UserSignupBloc, UserSignupState>(
              listener: (context, state) {
                if (state is UserSignupSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Signup successful!',
                        style: TextStyle(color: Colors.green),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  );
                } else if (state is UserSignupError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                if (state is UserSignupLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(height: 20.0),

                    const Text(
                      "Create Your Account as a Passenger",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),

                    // First Name Input
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      controller: firstNameController,
                      hintText: "First Name",
                    ),

                    // Last Name Input
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      controller: lastNameController,
                      hintText: "Last Name",
                    ),

                    // Phone Number Input
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      controller: phoneController,
                      hintText: "Phone Number (+977XXXXXXXXXX)",
                      keyboardType: TextInputType.phone,
                    ),

                    // Password Input
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 20.0),

                    // Navigate to Login Page
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),

                    // Create Account Button
                    CustomButton(
                      text: "Create Account",
                      onPressed: () {
                        final firstName = firstNameController.text.trim();
                        final lastName = lastNameController.text.trim();
                        String phone = phoneController.text.trim();
                        final password = passwordController.text.trim();

                        // Prepend +977 if not already included
                        if (!phone.startsWith('+977')) {
                          phone = '+977$phone';
                        }

                        // Input Validation
                        if (firstName.isEmpty) {
                          _showErrorSnackBar(context, 'First Name is required.');
                          return;
                        }
                        if (lastName.isEmpty) {
                          _showErrorSnackBar(context, 'Last Name is required.');
                          return;
                        }
                        if (phone.isEmpty) {
                          _showErrorSnackBar(
                              context, 'Phone number is required.');
                          return;
                        }
                        if (!RegExp(r'^\+977\d{10}\$').hasMatch(phone)) {
                          _showErrorSnackBar(
                              context,
                              'Phone number must start with +977 and contain exactly 10 digits.');
                          return;
                        }
                        if (password.isEmpty) {
                          _showErrorSnackBar(context, 'Password is required.');
                          return;
                        }
                        if (password.length < 8 ||
                            !RegExp(r'[A-Z]').hasMatch(password) ||
                            !RegExp(r'[a-z]').hasMatch(password) ||
                            !RegExp(r'[0-9]').hasMatch(password) ||
                            !RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
                          _showErrorSnackBar(
                              context,
                              'Password must be at least 8 characters long, include uppercase, lowercase, a number, and a special character.');
                          return;
                        }

                        // Trigger signup event
                        context.read<UserSignupBloc>().add(
                          UserSignupSubmit(
                            firstName: firstName,
                            lastName: lastName,
                            phoneNumber: phone,
                            password: password,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10.0),

                    // Sign up as Captain in Green
                    CustomButton(
                      text: "Sign up as Captain",
                      onPressed: () {
                        Navigator.pushNamed(context, '/captain-signup');
                      },
                      color: Colors.green,
                    ),
                  ],
                );
              },
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
