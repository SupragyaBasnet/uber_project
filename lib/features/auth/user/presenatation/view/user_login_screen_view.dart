import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/widgets/custom_elevated_button.dart';
import '../../../../../app/widgets/custom_text_field.dart';
import '../view_model/user_login_bloc.dart';
import '../view_model/user_login_event.dart';
import '../view_model/user_login_state.dart';

class UserLoginScreenView extends StatefulWidget {
  @override
  _UserLoginScreenViewState createState() => _UserLoginScreenViewState();
}

class _UserLoginScreenViewState extends State<UserLoginScreenView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<UserLoginBloc, UserLoginState>(
          listener: (context, state) {
            if (state is UserLoginSuccess) {
              Navigator.pushReplacementNamed(context, "/home");
            } else if (state is UserLoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// **App Logo**
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20),

                /// **Phone Number Input (✅ Fixed Prefix Text)**
                CustomTextField(
                  controller: _phoneController,
                  label: "Phone Number",
                  keyboardType: TextInputType.phone,
                  prefixText: "+977 ", // ✅ Corrected: Using `prefixText` in `CustomTextField`
                  validator: (value) =>
                  (value!.length == 10) ? null : "Enter a valid 10-digit number",
                ),
                const SizedBox(height: 15),

                /// **Password Input**
                CustomTextField(
                  controller: _passwordController,
                  label: "Password",
                  isPassword: true, // ✅ Fixed: Directly pass `true` for a password field
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  validator: (value) =>
                  (value!.length >= 6) ? null : "Password must be at least 6 characters",
                ),
                const SizedBox(height: 20),

                /// **Login Button**
                BlocBuilder<UserLoginBloc, UserLoginState>(
                  builder: (context, state) {
                    return CustomElevatedButton(
                      text: "Login",
                      isLoading: state is UserLoginLoading,
                      onPressed: () {
                        if (_phoneController.text.length == 10 &&
                            _passwordController.text.length >= 6) {
                          context.read<UserLoginBloc>().add(
                            UserLoginSubmitted(
                              phonenumber: _phoneController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter valid credentials"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),

                /// **Forgot Password Link**
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/forgot-password");
                  },
                  child: const Text("Forgot Password?"),
                ),
                const SizedBox(height: 10),

                /// **Signup Navigation**
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: const Text("New here? Create a new account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
