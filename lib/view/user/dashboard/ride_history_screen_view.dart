import 'package:flutter/material.dart';

class RideHistoryScreenView extends StatelessWidget {
  const RideHistoryScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride History'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: Icon(Icons.motorcycle, color: Colors.blue),
            title: Text('Bike Ride - Deep Jyoti Marg to Baneshwor'),
            subtitle: Text('Completed on 12 Dec, 2024'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.directions_car, color: Colors.blue),
            title: Text('Car Ride - Baluwatar to Thamel'),
            subtitle: Text('Completed on 10 Dec, 2024'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.auto_awesome, color: Colors.blue),
            title: Text('Autorickshaw Ride - Kalanki to New Road'),
            subtitle: Text('Completed on 8 Dec, 2024'),
          ),
        ],
      ),
    );
  }
}
