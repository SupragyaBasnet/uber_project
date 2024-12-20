import 'package:flutter/material.dart';

class CaptainDashboardScreenView extends StatelessWidget {
  const CaptainDashboardScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Captain Dashboard"),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the login screen
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dashboard Heading
              const Text(
                "Welcome, Captain!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Trip Management Section
              _buildDashboardButton(
                context,
                label: "Manage Trips",
                icon: Icons.directions_bus,
                onPressed: () {
                  // Navigate to Manage Trips screen (to be implemented)
                },
              ),
              const SizedBox(height: 15),

              // Earnings Section
              _buildDashboardButton(
                context,
                label: "View Earnings",
                icon: Icons.monetization_on,
                onPressed: () {
                  // Navigate to Earnings screen (to be implemented)
                },
              ),
              const SizedBox(height: 15),

              // Notifications Section
              _buildDashboardButton(
                context,
                label: "Notifications",
                icon: Icons.notifications,
                onPressed: () {
                  // Navigate to Notifications screen (to be implemented)
                },
              ),
              const SizedBox(height: 15),

              // Profile Management Section
              _buildDashboardButton(
                context,
                label: "Manage Profile",
                icon: Icons.person,
                onPressed: () {
                  // Navigate to Profile Management screen (to be implemented)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper method to create dashboard buttons
  Widget _buildDashboardButton(BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.white),
          const SizedBox(width: 15),
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
