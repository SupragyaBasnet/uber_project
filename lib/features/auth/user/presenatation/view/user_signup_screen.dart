import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/app/di/di.dart'; // Import Dependency Injection

import '../view_model/user_signup_bloc.dart';
import '../view_model/user_signup_event.dart';
import '../view_model/user_signup_state.dart';

class UserSignupScreen extends StatefulWidget {
  @override
  _UserSignupScreenState createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  void _registerUser() {
    final userData = {
      "fullname": {
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
      },
      "phonenumber": phoneController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };

    context.read<UserSignupBloc>().add(UserSignupRequested(userData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserSignupBloc>(), // ✅ Use Dependency Injection
      child: BlocListener<UserSignupBloc, UserSignupState>(
        listener: (context, state) {
          if (state is UserSignupSuccess) {
            Navigator.pushNamed(context, "/home");
          } else if (state is UserSignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ✅ Circular Logo
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/EasyGo.png"),
                  ),
                  SizedBox(height: 20),

                  // ✅ Title
                  Text(
                    "Create Your Account as a User",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),

                  // ✅ First Name & Last Name Fields
                  Row(
                    children: [
                      Expanded(child: _buildTextField("First Name", firstNameController)),
                      SizedBox(width: 10),
                      Expanded(child: _buildTextField("Last Name", lastNameController)),
                    ],
                  ),
                  SizedBox(height: 20),

                  // ✅ Email Field
                  _buildTextField("Email", emailController),
                  SizedBox(height: 20),

                  // ✅ Phone Number Field
                  _buildTextField("Phone Number", phoneController, prefix: "+977"),
                  SizedBox(height: 20),

                  // ✅ Password Field
                  _buildPasswordField(),
                  SizedBox(height: 30),

                  // ✅ Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _registerUser,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Sign Up", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 10),

                  // ✅ Already Have an Account? Login
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/login"),
                    child: Text("Already have an account? Login"),
                  ),
                  SizedBox(height: 10),

                  // ✅ Sign up as Captain Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, "/captain-signup"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Sign up as Captain", style: TextStyle(fontSize: 18)),
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

  Widget _buildTextField(String label, TextEditingController controller, {String? prefix}) {
    return TextField(
      controller: controller,
      keyboardType: label == "Phone Number" ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: passwordController,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        suffixIcon: IconButton(
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => showPassword = !showPassword),
        ),
      ),
    );
  }
}
