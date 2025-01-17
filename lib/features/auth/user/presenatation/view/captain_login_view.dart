import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/widgets/custom_button.dart';
import '../../../../../app/widgets/custom_text_field.dart';
import '../../../../../app/di/di.dart'; // Import your DI setup

import '../view_model/captain_login.bloc.dart';
import '../view_model/captain_login_event.dart';
import '../view_model/captain_login_state.dart';

class CaptainLoginScreenView extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<CaptainLoginBloc>(), // Ensure DI is properly set up
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EasyGo - Captain Login'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<CaptainLoginBloc, CaptainLoginState>(
              listener: (context, state) {
                if (state is CaptainLoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Login successful!',
                        style: TextStyle(color: Colors.green),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  );
                } else if (state is CaptainLoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                if (state is CaptainLoginLoading) {
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
                      "Login as Captain",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),

                    // Phone Number Input
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

                    const SizedBox(height: 10.0),

                    // Sign Up Button
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/captain-signup');
                      },
                      child: const Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // Login Button
                    CustomButton(
                      text: "Login",
                      onPressed: () {
                        String phone = phoneController.text.trim();
                        final password = passwordController.text.trim();

                        // Prepend +977 if not already included
                        if (!phone.startsWith('+977')) {
                          phone = '+977$phone';
                        }

                        // Input Validation
                        if (phone.isEmpty) {
                          _showErrorSnackBar(context, 'Phone number is required.');
                          return;
                        }
                        if (!RegExp(r'^\+977\d{10}$').hasMatch(phone)) {
                          _showErrorSnackBar(
                              context,
                              'Phone number must start with +977 and contain exactly 10 digits.');
                          return;
                        }
                        if (password.isEmpty) {
                          _showErrorSnackBar(context, 'Password is required.');
                          return;
                        }

                        // Trigger login event
                        context.read<CaptainLoginBloc>().add(
                          CaptainLoginSubmit(
                            phoneNumber: phone,
                            password: password,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10.0),

                    // Sign in as Passenger Button
                    CustomButton(
                      text: "Sign in as Passenger",
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      color: Colors.orange,
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
