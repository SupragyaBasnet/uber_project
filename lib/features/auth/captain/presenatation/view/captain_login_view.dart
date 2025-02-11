import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/app/di/di.dart';

import '../../../../../app/widgets/custom_text_field.dart';
import '../../../../../app/widgets/custom_elevated_button.dart';
import '../view_model/captain_login.bloc.dart';

import '../view_model/captain_login_event.dart';
import '../view_model/captain_login_state.dart';

class CaptainLoginScreenView extends StatefulWidget {
  const CaptainLoginScreenView({Key? key}) : super(key: key);

  @override
  _CaptainLoginScreenViewState createState() => _CaptainLoginScreenViewState();
}

class _CaptainLoginScreenViewState extends State<CaptainLoginScreenView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  /// ✅ **Helper Function to Show SnackBar**
  void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<CaptainLoginBloc>(),
      child: Scaffold(
        body: BlocListener<CaptainLoginBloc, CaptainLoginState>(
          listener: (context, state) {
            if (state is CaptainLoginSuccess) {
              Navigator.pushReplacementNamed(context, "/captain-home");
            } else if (state is CaptainLoginFailure) {
              showSnackBar(context, state.message, isError: true);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const AssetImage('assets/images/EasyGo.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Captain Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Phone Number
                  CustomTextField(
                    controller: _phonenumberController,
                    label: "Phone Number",
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                    value!.length == 10 ? null : "Enter a valid 10-digit number",
                  ),
                  const SizedBox(height: 10),

                  // Password
                  CustomTextField(
                    controller: _passwordController,
                    label: "Password",
                    isPassword: !_showPassword, // ✅ Fixed from `isObscure`
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() => _showPassword = !_showPassword);
                      },
                    ),
                    validator: (value) => value!.length >= 6
                        ? null
                        : "Password must be at least 6 characters",
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  CustomElevatedButton(
                    text: "Login",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<CaptainLoginBloc>().add(
                          CaptainLoginRequestEvent(
                            phonenumber: _phonenumberController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),

                  // Forgot Password
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/forgot-password"),
                    child: const Text("Forgot Password?"),
                  ),

                  // Sign up as Captain
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/captain-signup"),
                    child: const Text("New here? Create an account"),
                  ),

                  // Sign in as User
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/login"),
                    child: const Text("Sign in as Passenger"),
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
