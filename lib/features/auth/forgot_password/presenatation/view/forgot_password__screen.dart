import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/di/di.dart';
import '../../domain/use_case/forgot_password_usecase.dart';
import '../view_model/forgot_password_bloc.dart';
import '../widgets/password_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String userType = "user";
  int step = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        useCase: getIt<ForgotPasswordUseCase>(), // Ensure dependency injection works
      ),
      child: Scaffold(
        body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is OtpSentState) {
              setState(() => step = 2);
            } else if (state is OtpVerifiedState) {
              setState(() => step = 3);
            } else if (state is PasswordResetSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.pop(context);
            } else if (state is ForgotPasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/EasyGo.png", height: 80),
                SizedBox(height: 20),
                Text("Forgot Password", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),

                if (step == 1) ...[
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: userType,
                    onChanged: (value) => setState(() => userType = value!),
                    items: ["user", "captain"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    decoration: InputDecoration(labelText: "User Type", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<ForgotPasswordBloc>().add(SendOtpEvent(emailController.text, userType)),
                    child: Text("Send OTP"),
                  ),
                ],

                if (step == 2) ...[
                  TextField(
                    controller: otpController,
                    decoration: InputDecoration(labelText: "Enter OTP", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<ForgotPasswordBloc>().add(VerifyOtpEvent(emailController.text, otpController.text, userType)),
                    child: Text("Verify OTP"),
                  ),
                ],

                if (step == 3) ...[
                  PasswordInputField(label: "New Password", controller: newPasswordController),
                  PasswordInputField(label: "Confirm Password", controller: confirmPasswordController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<ForgotPasswordBloc>().add(
                      ResetPasswordEvent(emailController.text, otpController.text, newPasswordController.text, confirmPasswordController.text, userType),
                    ),
                    child: Text("Reset Password"),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
