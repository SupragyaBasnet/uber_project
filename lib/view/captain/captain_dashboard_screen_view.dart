import 'package:flutter/material.dart';

class CaptainDashboardScreenView extends StatelessWidget {
  const CaptainDashboardScreenView ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: const Text(
          'Welcome to the Dashboard!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
