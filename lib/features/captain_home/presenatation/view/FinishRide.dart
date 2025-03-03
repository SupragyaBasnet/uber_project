import 'package:flutter/material.dart';

class FinishRide extends StatelessWidget {
  final VoidCallback onDismiss;

  FinishRide({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          Text("Ride Completed!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: onDismiss,
            child: Text("OK"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}
