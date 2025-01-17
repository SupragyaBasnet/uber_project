import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/set_password_cubit.dart';

class SetPasswordView extends StatelessWidget {
  final String phoneNumber;

  const SetPasswordView({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SetPasswordCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<SetPasswordCubit, SetPasswordState>(
            listener: (context, state) {
              if (state is SetPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Password reset successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
              } else if (state is SetPasswordError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<SetPasswordCubit>();
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Set New Password",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: cubit.newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "New Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: cubit.confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => cubit.resetPassword(phoneNumber),
                      child: state is SetPasswordLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Set Password"),
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
