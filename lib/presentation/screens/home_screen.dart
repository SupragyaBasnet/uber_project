// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import ' history_screen.dart';
import '../provider/ride_provider.dart';

import 'booking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rideProvider = Provider.of<RideProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RideApp - Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: rideProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : rideProvider.errorMessage != null
          ? Center(child: Text(rideProvider.errorMessage!))
          : ListView.builder(
        itemCount: rideProvider.rides.length,
        itemBuilder: (context, index) {
          final ride = rideProvider.rides[index];
          return ListTile(
            title: Text('${ride.pickupLocation} → ${ride.dropoffLocation}'), // ✅ Fixed property names
            subtitle: Text('Fare: \$${ride.fare.toStringAsFixed(2)}'), // ✅ Format fare properly
            trailing: Text(ride.status),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingScreen()), // ✅ Removed `const`
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
