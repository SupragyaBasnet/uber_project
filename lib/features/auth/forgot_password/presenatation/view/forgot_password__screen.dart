import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uber_mobile_app_project/core/network/api_service.dart';
import '../../../../../app/di/di.dart';
import '../view_model/forgot_password_bloc.dart';
import '../view_model/forgot_password_state.dart';
import '../view_model/forgot_password_event.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _userType = "user";
  int _step = 1;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(apiService: serviceLocator<ApiService>()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Forgot Password")),
        body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              setState(() => _step = state.nextStep);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
              );
            } else if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (_step == 1) _buildEmailStep(context, state),
                  if (_step == 2) _buildOtpStep(context, state),
                  if (_step == 3) _buildResetPasswordStep(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Step 1: Enter Email & User Type
  Widget _buildEmailStep(BuildContext context, ForgotPasswordState state) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: "Enter your Email"),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _userType,
          onChanged: (value) => setState(() => _userType = value!),
          items: const [
            DropdownMenuItem(value: "user", child: Text("User")),
            DropdownMenuItem(value: "captain", child: Text("Captain")),
          ],
          decoration: const InputDecoration(labelText: "Select User Type"),
        ),
        const SizedBox(height: 20),
        _buildSubmitButton(
          label: "Send OTP",
          onPressed: () {
            BlocProvider.of<ForgotPasswordBloc>(context).add(
              SendOtpEvent(email: _emailController.text, userType: _userType),
            );
          },
          state: state,
        ),
      ],
    );
  }

  /// Step 2: Enter OTP
  Widget _buildOtpStep(BuildContext context, ForgotPasswordState state) {
    return Column(
      children: [
        TextField(
          controller: _otpController,
          decoration: const InputDecoration(labelText: "Enter OTP"),
        ),
        const SizedBox(height: 20),
        _buildSubmitButton(
          label: "Verify OTP",
          onPressed: () {
            BlocProvider.of<ForgotPasswordBloc>(context).add(
              VerifyOtpEvent(email: _emailController.text, otp: _otpController.text),
            );
          },
          state: state,
        ),
      ],
    );
  }

  /// Step 3: Reset Password
  Widget _buildResetPasswordStep(BuildContext context, ForgotPasswordState state) {
    return Column(
      children: [
        TextField(
          controller: _newPasswordController,
          obscureText: !_showNewPassword,
          decoration: InputDecoration(
            labelText: "New Password",
            suffixIcon: IconButton(
              icon: Icon(_showNewPassword ? LucideIcons.eye : LucideIcons.eyeOff),
              onPressed: () => setState(() => _showNewPassword = !_showNewPassword),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _confirmPasswordController,
          obscureText: !_showConfirmPassword,
          decoration: InputDecoration(
            labelText: "Confirm Password",
            suffixIcon: IconButton(
              icon: Icon(_showConfirmPassword ? LucideIcons.eye : LucideIcons.eyeOff),
              onPressed: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildSubmitButton(
          label: "Reset Password",
          onPressed: () {
            BlocProvider.of<ForgotPasswordBloc>(context).add(
              ResetPasswordEvent(
                email: _emailController.text,
                otp: _otpController.text,
                newPassword: _newPasswordController.text,
                confirmPassword: _confirmPasswordController.text, // ✅ Fixed
                userType: _userType,
              ),
            );
          },
          state: state,
        ),
      ],
    );
  }

  /// Generic Submit Button
  Widget _buildSubmitButton({
    required String label,
    required VoidCallback onPressed,
    required ForgotPasswordState state,
  }) {
    return ElevatedButton(
      onPressed: (state is ForgotPasswordLoading) ? null : onPressed,
      child: (state is ForgotPasswordLoading)
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(label),
    );
  }
}
