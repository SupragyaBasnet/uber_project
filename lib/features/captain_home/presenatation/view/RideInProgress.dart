import 'package:flutter/material.dart';

class RideInProgress extends StatelessWidget {
  final dynamic ride;
  final VoidCallback onComplete;

  RideInProgress({required this.ride, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.yellow,
      child: Column(
        children: [
          Text("${ride['distance']} km - ${ride['duration']} min", style: TextStyle(fontSize: 20)),
          ElevatedButton(
            onPressed: onComplete,
            child: Text("Complete Ride"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }
}
