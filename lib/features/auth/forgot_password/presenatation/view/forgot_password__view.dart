import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/features/auth/forgot_password/presenatation/view/otp_verification_view.dart';
import '../view_model/forgot_password_cubit.dart';

class ForgotPasswordView extends StatelessWidget {
  final String initialPhoneNumber;

  const ForgotPasswordView({
    Key? key,
    required this.initialPhoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state is ForgotPasswordSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpVerificationView(
                      phoneNumber: state.phoneNumber,
                    ),
                  ),
                );
              } else if (state is ForgotPasswordError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<ForgotPasswordCubit>();
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixText: "+977 ",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: cubit.sendOtp,
                      child: state is ForgotPasswordLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Send OTP"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
