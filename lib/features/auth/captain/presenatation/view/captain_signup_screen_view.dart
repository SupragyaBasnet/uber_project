import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_mobile_app_project/app/di/di.dart';

import '../../../../../app/widgets/custom_elevated_button.dart';
import '../../../../../app/widgets/custom_text_field.dart';
import '../view_model/captain_signup_bloc.dart';
import '../view_model/captain_signup_event.dart';
import '../view_model/captain_signup_state.dart';

class CaptainSignupScreenView extends StatefulWidget {
  const CaptainSignupScreenView({Key? key}) : super(key: key);

  @override
  _CaptainSignupScreenViewState createState() => _CaptainSignupScreenViewState();
}

class _CaptainSignupScreenViewState extends State<CaptainSignupScreenView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _vehicleColorController = TextEditingController();
  final TextEditingController _vehiclePlateController = TextEditingController();
  final TextEditingController _vehicleCapacityController = TextEditingController();
  String _vehicleType = '';
  bool _showPassword = false;
  File? _selectedImage;

  /// ✅ **Helper Function to Show SnackBar**
  void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// ✅ **Function to Pick Image from Camera or Gallery**
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<CaptainSignupBloc>(),
      child: Scaffold(
        body: BlocListener<CaptainSignupBloc, CaptainSignupState>(
          listener: (context, state) {
            if (state is CaptainSignupSuccess) {
              Navigator.pushReplacementNamed(context, "/captain-home");
            } else if (state is CaptainSignupFailure) {
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
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const AssetImage('assets/images/profile_placeholder.png') as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera),
                        onPressed: () => _pickImage(ImageSource.camera),
                      ),
                      IconButton(
                        icon: const Icon(Icons.photo_library),
                        onPressed: () => _pickImage(ImageSource.gallery),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: _firstNameController,
                    label: "First Name",
                    validator: (value) => value!.isNotEmpty ? null : "Enter first name",
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    controller: _lastNameController,
                    label: "Last Name",
                    validator: (value) => value!.isNotEmpty ? null : "Enter last name",
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    controller: _emailController,
                    label: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.contains('@') ? null : "Enter a valid email",
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    controller: _phonenumberController,
                    label: "Phone Number",
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.length == 10 ? null : "Enter a valid 10-digit number",
                  ),
                  const SizedBox(height: 10),

                  /// ✅ **Fixed obscureText issue**
                  CustomTextField(
                    controller: _passwordController,
                    label: "Password",
                    isPassword: !_showPassword, // ✅ Fixed from isObscure
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() => _showPassword = !_showPassword);
                      },
                    ),
                    validator: (value) => value!.length >= 6 ? null : "Password must be at least 6 characters",
                  ),
                  const SizedBox(height: 10),

                  CustomElevatedButton(
                    text: "Sign Up",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<CaptainSignupBloc>().add(
                          CaptainSignupRequestEvent(
                            phonenumber: _phonenumberController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            firstname: _firstNameController.text.trim(),
                            lastname: _lastNameController.text.trim(),
                            vehicleColor: _vehicleColorController.text.trim(),
                            vehiclePlate: _vehiclePlateController.text.trim(),
                            vehicleCapacity: _vehicleCapacityController.text.trim(),
                            vehicleType: _vehicleType,
                            image: _selectedImage,
                          ),
                        );
                      }
                    },
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
