import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // ✅ Import Google Maps
import 'package:provider/provider.dart';

import '../provider/ride_provider.dart';


class TrackingScreen extends StatefulWidget {
  final String rideId;

  const TrackingScreen({Key? key, required this.rideId}) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late GoogleMapController _mapController;
  LatLng _driverLocation = const LatLng(27.7172, 85.3240); // ✅ Default location in Kathmandu

  @override
  void initState() {
    super.initState();
    _fetchRideLocation();
  }

  void _fetchRideLocation() async {
    final rideProvider = Provider.of<RideProvider>(context, listen: false);
    final ride = rideProvider.getRideById(widget.rideId); // ✅ No need for await since it's synchronous

    if (ride != null) {
      setState(() {
        _driverLocation = LatLng(ride.driverLatitude, ride.driverLongitude);
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ride Tracking")),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _driverLocation,
          zoom: 14.0,
        ),
        markers: {
          Marker(markerId: const MarkerId("driver"), position: _driverLocation),
        },
      ),
    );
  }
}
