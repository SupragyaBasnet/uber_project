import 'package:flutter/material.dart';

import 'admin_login_screen_view.dart';

class AdminDashboardScreenView extends StatelessWidget {
  const AdminDashboardScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Admin Control Panel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Example of a button to manage users
            ElevatedButton(
              onPressed: () {
                // Logic to navigate to the user management section
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navigating to Manage Users'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Manage Users'),
            ),
            const SizedBox(height: 16),

            // Example of a button to view app statistics
            ElevatedButton(
              onPressed: () {
                // Logic to navigate to app stats section
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navigating to View App Stats'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Button color
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('View App Stats'),
            ),
            const SizedBox(height: 16),

            // Example of a button to log out
            ElevatedButton(
              onPressed: () {
                // Logic to log out and navigate to the login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminLoginScreenView(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button color
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
