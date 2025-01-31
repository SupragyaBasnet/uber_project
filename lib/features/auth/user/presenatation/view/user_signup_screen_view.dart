import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_mobile_app_project/app/di/di.dart';

import '../../../../../app/widgets/custom_elevated_button.dart';
import '../../../../../app/widgets/custom_text_field.dart';
import '../view_model/user_signup_bloc.dart';
import '../view_model/user_signup_event.dart';
import '../view_model/user_signup_state.dart';

class UserSignupScreenView extends StatefulWidget {
  const UserSignupScreenView({Key? key}) : super(key: key);

  @override
  _UserSignupScreenViewState createState() => _UserSignupScreenViewState();
}

class _UserSignupScreenViewState extends State<UserSignupScreenView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  File? _selectedImage;

  /// ✅ Function to Pick Image from Camera or Gallery
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  /// ✅ Function to Show SnackBar
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
      create: (_) => serviceLocator<UserSignupBloc>(),
      child: Scaffold(
        body: BlocListener<UserSignupBloc, UserSignupState>(
          listener: (context, state) {
            if (state is UserSignupSuccess) {
              Navigator.pushReplacementNamed(context, "/home");
            } else if (state is UserSignupFailure) {
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

                  /// ✅ Profile Picture Selection
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

                  /// ✅ First Name & Last Name Fields
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _firstnameController,
                          label: "First Name",
                          validator: (value) => value!.isNotEmpty ? null : "Enter first name",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          controller: _lastnameController,
                          label: "Last Name",
                          validator: (value) => value!.isNotEmpty ? null : "Enter last name",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// ✅ Email Field
                  CustomTextField(
                    controller: _emailController,
                    label: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.contains("@") ? null : "Enter a valid email",
                  ),
                  const SizedBox(height: 10),

                  /// ✅ Phone Number Field
                  CustomTextField(
                    controller: _phonenumberController,
                    label: "Phone Number",
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.length == 10 ? null : "Enter a valid 10-digit number",
                  ),
                  const SizedBox(height: 10),

                  /// ✅ Password Field
                  CustomTextField(
                    controller: _passwordController,
                    label: "Password",
                    isPassword: true,
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() => _showPassword = !_showPassword);
                      },
                    ),
                    validator: (value) => value!.length >= 6 ? null : "Password must be at least 6 characters",
                  ),
                  const SizedBox(height: 20),

                  /// ✅ Signup Button
                  CustomElevatedButton(
                    text: "Create Account",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<UserSignupBloc>().add(
                          UserSignupRequestEvent(
                            firstname: _firstnameController.text.trim(),
                            lastname: _lastnameController.text.trim(),
                            phonenumber: _phonenumberController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            image: _selectedImage, // ✅ Passing image file
                          ),
                        );
                      }
                    },
                  ),

                  /// ✅ Login Redirection
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/login"),
                    child: const Text("Already have an account? Login"),
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
