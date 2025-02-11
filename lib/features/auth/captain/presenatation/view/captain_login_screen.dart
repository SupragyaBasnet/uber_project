import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/app/di/di.dart'; // ✅ Import DI for CaptainLoginBloc


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
      "phonenumber": phoneController.text.trim(),
      "password": passwordController.text.trim(),
    };

    context.read<CaptainLoginBloc>().add(CaptainLoginRequested(data));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CaptainLoginBloc>(), // ✅ Inject CaptainLoginBloc from DI
      child: BlocListener<CaptainLoginBloc, CaptainLoginState>(
        listener: (context, state) {
          if (state is CaptainLoginSuccess) {
            Navigator.pushNamed(context, "/captain-home");
          } else if (state is CaptainLoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset("assets/EasyGo.png", height: 100), // Logo
                SizedBox(height: 20),
                Text(
                  "Captain Login",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                _buildTextField("Phone Number", phoneController, prefix: "+977"),
                SizedBox(height: 15),
                _buildPasswordField(),

                SizedBox(height: 25),

                ElevatedButton(
                  onPressed: _loginCaptain,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text("Login"),
                ),

                SizedBox(height: 15),

                TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/captain-signup"),
                  child: Text("Create new account", style: TextStyle(fontSize: 14)),
                ),

                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/user-login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text("Sign in as Passenger"),
                ),
              ],
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
