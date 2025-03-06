import 'package:easygo/features/rides/presentation/view/rideConfirmedPage.dart';
import 'package:flutter/material.dart';
import '../../data/services/ride_service.dart';
import '../../domain/models/ride_fare.dart';

class RideSelectionPage extends StatefulWidget {
  final String origin;
  final String destination;

  const RideSelectionPage(
      {Key? key, required this.origin, required this.destination})
      : super(key: key);

  @override
  State<RideSelectionPage> createState() => _RideSelectionPageState();
}

class _RideSelectionPageState extends State<RideSelectionPage> {
  final RideService _rideService = RideService();
  bool _isLoading = true;
  RideFare? _rideFare;
  String? _error;
  String? _selectedRideType;
  bool _isBooking = false;

  @override
  void initState() {
    super.initState();
    _fetchRideFare();
  }

  Future<void> _fetchRideFare() async {
    try {
      final fare = await _rideService.getRideFare(
        widget.origin,
        widget.destination,
      );

      if (mounted) {
        setState(() {
          _rideFare = fare;
          _isLoading = false;
          _selectedRideType = 'car'; // Default selection
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _bookRide() async {
    if (_selectedRideType == null || _isBooking) return;

    setState(() {
      _isBooking = true;
    });

    try {
      // Show a loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Creating your ride request...'),
          duration: Duration(seconds: 1),
        ),
      );

      // final result = await _rideService.createRide(
      //   pickup: widget.origin,
      //   destination: widget.destination,
      //   vehicleType: _selectedRideType!,
      // );

      if (mounted) {
        // print('Ride created successfully: $result');
        // Navigate to ride searching page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RideSearchingPage(
              origin: widget.origin,
              destination: widget.destination,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        print('Error booking ride: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to book ride: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _bookRide,
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isBooking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Ride'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Journey details
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Journey',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.trip_origin, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.origin,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      height: 20,
                      width: 2,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.destination,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Available Rides',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Ride options
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_error != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error loading ride options: $_error',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _fetchRideFare,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: ListView(
                  children: [
                    // Car option
                    _buildRideOption(
                      'car',
                      'Car',
                      'Private, comfortable ride',
                      Icons.directions_car,
                      _rideFare!.car,
                    ),

                    // Auto option
                    _buildRideOption(
                      'auto',
                      'Auto Rickshaw',
                      'Economical three-wheeler',
                      Icons.electric_rickshaw,
                      _rideFare!.auto,
                    ),

                    // Motorcycle option
                    _buildRideOption(
                      'moto',
                      'Motorcycle',
                      'Quick ride for one person',
                      Icons.motorcycle,
                      _rideFare!.moto,
                    ),
                  ],
                ),
              ),

            // Book button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _rideFare == null || _isBooking ? null : _bookRide,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isBooking
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Book Ride Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideOption(
    String id,
    String name,
    String description,
    IconData icon,
    double price,
  ) {
    final isSelected = _selectedRideType == id;

    return Card(
      elevation: isSelected ? 4 : 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.red.shade700 : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedRideType = id;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 30, color: Colors.red.shade700),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Rs. ${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Cash',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RideSearchingPage extends StatefulWidget {
  final String origin;
  final String destination;

  const RideSearchingPage(
      {Key? key, required this.origin, required this.destination})
      : super(key: key);

  @override
  State<RideSearchingPage> createState() => _RideSearchingPageState();
}

class _RideSearchingPageState extends State<RideSearchingPage> {
  @override
  void initState() {
    super.initState();
    // Set timer to navigate to ride confirmed page after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RideConfirmedPage(
              origin: widget.origin,
              destination: widget.destination,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finding your ride'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Journey details card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Journey',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.trip_origin, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.origin,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      height: 20,
                      width: 2,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.destination,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              'Searching for nearby drivers...',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              'Please wait while we connect you with a driver',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
