import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/otp_verification_cubit.dart';
import 'set_password_view.dart';

class OtpVerificationView extends StatelessWidget {
  final String phoneNumber;

  const OtpVerificationView({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpVerificationCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
            listener: (context, state) {
              if (state is OtpVerificationSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SetPasswordView(
                      phoneNumber: phoneNumber,
                    ),
                  ),
                );
              } else if (state is OtpVerificationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<OtpVerificationCubit>();
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "OTP Verification",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: cubit.otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration: const InputDecoration(
                        labelText: "Enter OTP",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => cubit.verifyOtp(phoneNumber),
                      child: state is OtpVerificationLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Verify OTP"),
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
