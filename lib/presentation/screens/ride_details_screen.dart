import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/ride_provider.dart';
 // ✅ Fixed import path
import '../../data/models/ride_model.dart';

class RideDetailsScreen extends StatelessWidget {
  final String rideId;

  const RideDetailsScreen({Key? key, required this.rideId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rideProvider = Provider.of<RideProvider>(context);
    final Ride? ride = rideProvider.getRideById(rideId);

    return Scaffold(
      appBar: AppBar(title: const Text('Ride Details')),
      body: ride == null
          ? const Center(child: Text("Ride not found"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Driver: ${ride.driverName}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Pickup: ${ride.pickupLocation}'),
            Text('Destination: ${ride.dropoffLocation}'),
            Text('Fare: \$${ride.fare.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                rideProvider.cancelRide(rideId); // ✅ Ensure cancelRide exists
                Navigator.pop(context);
              },
              child: const Text('Cancel Ride'),
            ),
          ],
        ),
      ),
    );
  }
}
