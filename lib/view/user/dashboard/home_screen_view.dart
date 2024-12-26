import 'package:flutter/material.dart';
import '../../../model/user/home.dart';
import 'fare_screen_view.dart'; // Import the new screen

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text('Home'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7, // Increased flex to make the map larger
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/map.png'), // Replace with your map image
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Add functionality for location or map control
                      },
                      backgroundColor: Colors.black,
                      child: const Icon(Icons.my_location, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5, // Reduced flex for the bottom container
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Select Ride Mode',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RideOptionButton(
                          icon: Icons.motorcycle,
                          label: 'Bike',
                          color: Colors.green,
                          onTap: () {
                            // Handle bike ride selection
                          },
                        ),
                        RideOptionButton(
                          icon: Icons.directions_car,
                          label: 'Car',
                          color: Colors.blue,
                          onTap: () {
                            // Handle car ride selection
                          },
                        ),
                        RideOptionButton(
                          icon: Icons.electric_car,
                          label: 'EV Car',
                          color: Colors.teal,
                          onTap: () {
                            // Handle EV car ride selection
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Current Location',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Destination',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_pin),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FareScreenView(),
                          ),
                        );
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Fare (Estimated)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.money),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
