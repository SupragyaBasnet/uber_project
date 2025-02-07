import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/ride_provider.dart';
import '../../data/models/ride_model.dart'; // ✅ Ensure correct model import

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ride History')),
      body: Consumer<RideProvider>(
        builder: (context, rideProvider, child) {
          return FutureBuilder<List<Ride>>(
            future: rideProvider.getRideHistory(), // ✅ Ensure this method exists
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching ride history.'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No ride history found.'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final ride = snapshot.data![index];
                    return ListTile(
                      title: Text('${ride.pickupLocation} → ${ride.dropoffLocation}'),
                      subtitle: Text('Date: ${ride.date.toString()} | Fare: \$${ride.fare.toStringAsFixed(2)}'),
                      trailing: const Icon(Icons.arrow_forward),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
