import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/captain_signup_bloc.dart';
import '../view_model/captain_signup_event.dart';
import '../view_model/captain_signup_state.dart';

class CaptainSignupScreen extends StatefulWidget {
  @override
  _CaptainSignupScreenState createState() => _CaptainSignupScreenState();
}

class _CaptainSignupScreenState extends State<CaptainSignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController vehicleNameController = TextEditingController();
  final TextEditingController vehiclePlateController = TextEditingController();
  final TextEditingController vehicleCapacityController = TextEditingController();

  String vehicleType = "car";
  bool showPassword = false;

  void _registerCaptain() {
    final data = {
      "fullname": {
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
      },
      "phonenumber": phoneController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "vehicle": {
        "name": vehicleNameController.text,
        "plate": vehiclePlateController.text,
        "capacity": vehicleCapacityController.text,
        "vehicleType": vehicleType,
      },
    };

    BlocProvider.of<CaptainSignupBloc>(context).add(CaptainSignupRequested(data)); // ✅ Fixed event name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CaptainSignupBloc, CaptainSignupState>(
        listener: (context, state) {
          if (state is CaptainSignupSuccess) {
            Navigator.pushNamed(context, "/captain-home");
          } else if (state is CaptainSignupFailure) {
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
              Text("Create Rider's Account", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              // Name Fields
              Row(
                children: [
                  Expanded(child: _buildTextField("First Name", firstNameController)),
                  SizedBox(width: 10),
                  Expanded(child: _buildTextField("Last Name", lastNameController)),
                ],
              ),

              _buildTextField("Email", emailController),
              _buildTextField("Phone Number", phoneController, prefix: "+977"),

              // Password
              _buildPasswordField(),

              SizedBox(height: 20),
              Text("Vehicle Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              _buildTextField("Vehicle Name", vehicleNameController),
              _buildTextField("Vehicle Plate", vehiclePlateController),
              _buildTextField("Vehicle Capacity", vehicleCapacityController),

              // Vehicle Type Dropdown
              DropdownButton<String>(
                value: vehicleType,
                onChanged: (String? newValue) {
                  setState(() {
                    vehicleType = newValue!;
                  });
                },
                items: ["car", "motorcycle", "auto"].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerCaptain,
                child: Text("Sign Up"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/captain-login"),
                child: Text("Already have an account? Login"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/user-login"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Sign up as Passenger"),
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
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off), // ✅ Fixed LucideIcons
          onPressed: () => setState(() => showPassword = !showPassword),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
