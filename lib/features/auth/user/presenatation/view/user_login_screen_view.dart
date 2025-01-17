import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/widgets/custom_button.dart';
import '../view_model/user_login_bloc.dart';
import '../view_model/user_login_event.dart';
import '../view_model/user_login_state.dart';
import '../../../../../app/di/di.dart'; // Import your DI setup

class UserLoginScreenView extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<UserLoginBloc>(), // Provide the UserLoginBloc
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EasyGo'),
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
                  "Login as a Passenger",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // BlocConsumer for Login Logic
                BlocConsumer<UserLoginBloc, UserLoginState>(
                  listener: (context, state) {
                    if (state is UserLoginSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Login successful!',
                            style: TextStyle(color: Colors.green),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      );
                    } else if (state is UserLoginError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UserLoginLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Phone Number Input
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number (+977XXXXXXXXXX)',
                            border: OutlineInputBorder(),
                            hintText: 'Enter your phone number',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password Input
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            hintText: 'Enter your password',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Don't have an account? Sign up text
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: const Text(
                            'Don\'t have an account? Sign up',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),

                        // Login Button
                        const SizedBox(height: 16),
                        CustomButton(
                          text: 'Login',
                          onPressed: () {
                            String phone = phoneController.text.trim();
                            final password = passwordController.text.trim();

                            // Prepend +977 if not already included
                            if (!phone.startsWith('+977')) {
                              phone = '+977$phone';
                            }

                            // Validation
                            if (phone.isEmpty) {
                              _showErrorSnackBar(
                                  context, 'Phone number is required.');
                              return;
                            }

                            if (!RegExp(r'^\+977\d{10}$').hasMatch(phone)) {
                              _showErrorSnackBar(
                                  context,
                                  'Phone number must start with +977 and contain exactly 10 digits.');
                              return;
                            }


                            if (password.isEmpty) {
                              _showErrorSnackBar(
                                  context, 'Password is required.');
                              return;
                            }

                            if (password.length < 8 ||
                                !RegExp(r'[A-Z]').hasMatch(password) ||
                                !RegExp(r'[a-z]').hasMatch(password) ||
                                !RegExp(r'[0-9]').hasMatch(password) ||
                                !RegExp(r'[!@#\\$%^&*(),.?":{}|<>]').hasMatch(password)) {
                              _showErrorSnackBar(
                                  context,
                                  'Password must be at least 8 characters long, include uppercase, lowercase, a number, and a special character.');
                              return;
                            }

                            // Trigger login event
                            context.read<UserLoginBloc>().add(
                              UserLoginSubmit(
                                  phoneNumber: phone, password: password),
                            );
                          },
                        ),
                        const SizedBox(height: 10),

                        // Login as Captain Button in green
                        CustomButton(
                          text: 'Login as Captain',
                          onPressed: () {
                            Navigator.pushNamed(context, '/captain-login');
                          },
                          color: Colors.green,
                        ),
                      ],
                    );
                  },
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
