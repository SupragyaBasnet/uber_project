import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../view_model/captain_login.bloc.dart';
import '../view_model/captain_login_event.dart';
import '../view_model/captain_login_state.dart';

class CaptainLoginScreen extends StatefulWidget {
  @override
  _CaptainLoginScreenState createState() => _CaptainLoginScreenState();
}

class _CaptainLoginScreenState extends State<CaptainLoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  void _loginCaptain() {
    final data = {
      "phonenumber": phoneController.text,
      "password": passwordController.text,
    };

    BlocProvider.of<CaptainLoginBloc>(context).add(CaptainLoginRequested(data)); // ✅ Fixed event name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CaptainLoginBloc, CaptainLoginState>(
        listener: (context, state) {
          if (state is CaptainLoginSuccess) {
            Navigator.pushNamed(context, "/captain-home");
          } else if (state is CaptainLoginFailure) {
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
              Text("Captain Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              _buildTextField("Phone Number", phoneController, prefix: "+977"),
              _buildPasswordField(),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginCaptain,
                child: Text("Login"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/captain-signup"),
                child: Text("Create new account"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/user-login"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text("Sign in as Passenger"),
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
