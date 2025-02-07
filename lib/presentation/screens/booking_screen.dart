import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/ride_provider.dart';


class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropoffController = TextEditingController();

  void _bookRide() async {
    final rideProvider = Provider.of<RideProvider>(context, listen: false);

    // ✅ Corrected RideModel -> Ride
    final newRide = {
      "pickupLocation": pickupController.text,
      "dropoffLocation": dropoffController.text,
      "fare": 10.0, // You can modify this based on actual calculation
      "status": "pending",
    };

    final success = await rideProvider.bookRide(newRide); // ✅ Ensure this method exists

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ride booked successfully!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to book ride. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book a Ride')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pickupController,
              decoration: const InputDecoration(labelText: 'Pickup Location'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dropoffController,
              decoration: const InputDecoration(labelText: 'Dropoff Location'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _bookRide,
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
