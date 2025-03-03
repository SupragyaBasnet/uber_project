import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/app/di/di.dart'; // ✅ Import DI for UserLoginBloc

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

    context.read<UserLoginBloc>().add(UserLoginRequested(credentials));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserLoginBloc>(), // ✅ Inject UserLoginBloc from DI
      child: BlocListener<UserLoginBloc, UserLoginState>(
        listener: (context, state) {
          if (state is UserLoginSuccess) {
            Navigator.pushNamed(context, "/home");
          } else if (state is UserLoginFailure) {
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
                    "User Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),

                  // ✅ Phone Number Field
                  _buildTextField("Phone Number", phoneController, prefix: "+977"),
                  SizedBox(height: 20),

                  // ✅ Password Field
                  _buildPasswordField(),
                  SizedBox(height: 20),

                  // ✅ Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, "/forgot-password"),
                      child: Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
                    ),
                  ),

                  // ✅ Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loginUser,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Login", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 10),

                  // ✅ Signup Link
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/signup"),
                    child: Text("New here? Create an account"),
                  ),
                  SizedBox(height: 10),

                  // ✅ Sign in as Captain Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, "/captain-login"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Sign in as Captain", style: TextStyle(fontSize: 18)),
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
      keyboardType: TextInputType.phone,
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
