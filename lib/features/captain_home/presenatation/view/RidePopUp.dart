import 'package:flutter/material.dart';

class RidePopUp extends StatelessWidget {
  final dynamic ride;
  final VoidCallback onAccept;
  final VoidCallback onIgnore;

  RidePopUp({required this.ride, required this.onAccept, required this.onIgnore});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("New Ride Available!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("Pickup: ${ride['pickup']}"),
          Text("Destination: ${ride['destination']}"),
          Text("Fare: Rs. ${ride['fare']}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onAccept,
                child: Text("Accept"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              ElevatedButton(
                onPressed: onIgnore,
                child: Text("Ignore"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
