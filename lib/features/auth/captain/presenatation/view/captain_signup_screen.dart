import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/app/di/di.dart'; // ✅ Import DI for CaptainSignupBloc

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
        "firstname": firstNameController.text.trim(),
        "lastname": lastNameController.text.trim(),
      },
      "phonenumber": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "vehicle": {
        "name": vehicleNameController.text.trim(),
        "plate": vehiclePlateController.text.trim(),
        "capacity": vehicleCapacityController.text.trim(),
        "vehicleType": vehicleType,
      },
    };

    context.read<CaptainSignupBloc>().add(CaptainSignupRequested(data));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CaptainSignupBloc>(), // ✅ Inject CaptainSignupBloc from DI
      child: BlocListener<CaptainSignupBloc, CaptainSignupState>(
        listener: (context, state) {
          if (state is CaptainSignupSuccess) {
            Navigator.pushNamed(context, "/captain-home");
          } else if (state is CaptainSignupFailure) {
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
                    "Create Rider's Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),

                  // ✅ Name Fields
                  Row(
                    children: [
                      Expanded(child: _buildTextField("First Name", firstNameController)),
                      SizedBox(width: 10),
                      Expanded(child: _buildTextField("Last Name", lastNameController)),
                    ],
                  ),
                  SizedBox(height: 20),

                  // ✅ Email & Phone Fields
                  _buildTextField("Email", emailController),
                  SizedBox(height: 20),
                  _buildTextField("Phone Number", phoneController, prefix: "+977"),
                  SizedBox(height: 20),

                  // ✅ Password Field
                  _buildPasswordField(),
                  SizedBox(height: 30),

                  // ✅ Vehicle Information
                  Text(
                    "Vehicle Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  _buildTextField("Vehicle Name", vehicleNameController),
                  SizedBox(height: 20),
                  _buildTextField("Vehicle Plate", vehiclePlateController),
                  SizedBox(height: 20),
                  _buildTextField("Vehicle Capacity", vehicleCapacityController),
                  SizedBox(height: 20),

                  // ✅ Vehicle Type Dropdown
                  DropdownButtonFormField<String>(
                    value: vehicleType,
                    decoration: InputDecoration(
                      labelText: "Select Vehicle Type",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        vehicleType = newValue!;
                      });
                    },
                    items: ["car", "motorcycle", "auto"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.toUpperCase()),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 30),

                  // ✅ Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _registerCaptain,
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
                    onPressed: () => Navigator.pushNamed(context, "/captain-login"),
                    child: Text("Already have an account? Login"),
                  ),
                  SizedBox(height: 10),

                  // ✅ Sign up as Passenger Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, "/signup"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Sign up as Passenger", style: TextStyle(fontSize: 18)),
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
      keyboardType: label == "Phone Number" || label == "Vehicle Capacity"
          ? TextInputType.phone
          : TextInputType.text,
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
