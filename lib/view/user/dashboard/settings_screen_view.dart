import 'package:flutter/material.dart';

class SettingsScreenView extends StatelessWidget {
  const SettingsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('Profile'),
            onTap: () {
              // Handle Profile Navigation
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.blue),
            title: const Text('Change Password'),
            onTap: () {
              // Handle Password Change
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.blue),
            title: const Text('Logout'),
            onTap: () {
              // Handle Logout
            },
          ),
        ],
      ),
    );
  }
}
