import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    BlocProvider.of<UserSignupBloc>(context).add(UserSignupRequested(userData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserSignupBloc, UserSignupState>(
        listener: (context, state) {
          if (state is UserSignupSuccess) {
            Navigator.pushNamed(context, "/home");
          } else if (state is UserSignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 50),
              Image.asset("assets/EasyGo.png", height: 100), // Logo
              SizedBox(height: 20),
              Text("Create Your Account", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              Row(
                children: [
                  Expanded(child: _buildTextField("First Name", firstNameController)),
                  SizedBox(width: 10),
                  Expanded(child: _buildTextField("Last Name", lastNameController)),
                ],
              ),

              _buildTextField("Email", emailController),
              _buildTextField("Phone Number", phoneController, prefix: "+977"),
              _buildPasswordField(),

              SizedBox(height: 20),

              // ✅ Register Button
              ElevatedButton(
                onPressed: _registerUser,
                child: Text("Sign Up"),
              ),

              SizedBox(height: 10),

              // ✅ Login Button
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/login"),
                child: Text("Already have an account? Login"),
              ),

              // ✅ Signup as Captain Button
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/captain-signup"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Sign up as Captain"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {String? prefix}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefix,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: passwordController,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: IconButton(
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => showPassword = !showPassword),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
