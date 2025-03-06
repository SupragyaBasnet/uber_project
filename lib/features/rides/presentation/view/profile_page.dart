import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profile.jpeg'),
            // If you don't have this image, you can use a placeholder instead:
            // child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 20),
          const Text(
            'Supragya Basnet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Supragyabasnet@gmail.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          _buildProfileItem(Icons.history, 'Ride History'),
          _buildProfileItem(Icons.payment, 'Payment Methods'),
          _buildProfileItem(Icons.favorite, 'Favorite Destinations'),
          _buildProfileItem(Icons.settings, 'Settings'),
          _buildProfileItem(Icons.help, 'Help & Support'),
          _buildProfileItem(Icons.logout, 'Log Out'),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle item tap
        },
      ),
    );
  }
}
