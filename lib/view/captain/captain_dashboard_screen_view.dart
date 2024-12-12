import 'package:flutter/material.dart';

class CaptainDashboardScreenView extends StatelessWidget {
  const CaptainDashboardScreenView ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uber'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Welcome to the Dashboard!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
