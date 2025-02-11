import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/user_login_bloc.dart';
import '../view_model/user_login_event.dart';
import '../view_model/user_login_state.dart';


class UserLoginScreen extends StatefulWidget {
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  void _loginUser() {
    final credentials = {
      "phonenumber": phoneController.text,
      "password": passwordController.text,
    };

    BlocProvider.of<UserLoginBloc>(context).add(UserLoginRequested(credentials));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserLoginBloc, UserLoginState>(
        listener: (context, state) {
          if (state is UserLoginSuccess) {
            Navigator.pushNamed(context, "/home");
          } else if (state is UserLoginFailure) {
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
              Text("User Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              _buildTextField("Phone Number", phoneController, prefix: "+977"),
              _buildPasswordField(),

              SizedBox(height: 20),

              // ✅ Forgot Password Link
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/forgot-password"),
                child: Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
              ),

              // ✅ Login Button
              ElevatedButton(
                onPressed: _loginUser,
                child: Text("Login"),
              ),

              SizedBox(height: 10),

              // ✅ Signup Button
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/signup"),
                child: Text("New here? Create an account"),
              ),

              // ✅ Sign in as Captain Button
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/captain-login"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Sign in as Captain"),
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
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off), // ✅ Material Icons Used
          onPressed: () => setState(() => showPassword = !showPassword),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
