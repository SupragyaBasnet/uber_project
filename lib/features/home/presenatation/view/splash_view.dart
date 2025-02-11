import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/features/splash/presenatation/view_model/splash_cubit.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: Builder(
        builder: (context) {
          // Start Splash Logic
          context.read<SplashCubit>().init(context);

          return Scaffold(
            backgroundColor: Colors.blueGrey[50],
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: const AssetImage('assets/images/logo.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'EasyGo',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  const Text('version: 1.0.0'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
