import 'package:flutter/material.dart';
import 'rides_page.dart';
import 'profile_page.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'dart:async';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<int>? _proximitySensorSubscription;
  DateTime? _lastShakeTime;
  DateTime? _lastAboutTriggerTime;
  static const double _shakeThreshold = 10.0;

  final List<Widget> _pages = [
    const RidesPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _initAccelerometer();
    _initProximitySensor();
  }

  void _initAccelerometer() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      _detectShake(event);
    });
  }

  void _initProximitySensor() {
    _proximitySensorSubscription = ProximitySensor.events.listen((int event) {
      _detectAboutTrigger(event);
    });
  }

  void _detectAboutTrigger(int proximity) {
    // Check if object is near (proximity == 0)
    print('Proximity: $proximity');
    if (proximity < 0.1) {
      final now = DateTime.now();
      // Prevent multiple triggers in short succession
      if (_lastAboutTriggerTime == null ||
          now.difference(_lastAboutTriggerTime!) >
              const Duration(seconds: 10)) {
        _lastAboutTriggerTime = now;
        _showSupportPage();
      }
    }
  }

  void _showSupportPage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About EasyGO'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'EasyGO Ride Sharing App',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  'EasyGO is a convenient ride sharing platform designed to make transportation accessible and affordable for everyone.',
                ),
                SizedBox(height: 12),
                Text(
                  'Features:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    '• Quick ride booking\n• Real-time tracking\n• Secure payments\n• Ride history\n• Driver ratings'),
                SizedBox(height: 12),
                Text(
                  'Need help? Contact us:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('support@easygo.com\n+1-800-EASYGO'),
                SizedBox(height: 16),
                Text(
                  'Developed by Supragya Basnet',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _detectShake(AccelerometerEvent event) {
    double acceleration =
        event.x * event.x + event.y * event.y + event.z * event.z;

    // Check if acceleration exceeds threshold
    if (acceleration > _shakeThreshold * _shakeThreshold) {
      final now = DateTime.now();
      // Prevent multiple shake detections in short succession
      if (_lastShakeTime == null ||
          now.difference(_lastShakeTime!) > const Duration(seconds: 5)) {
        _lastShakeTime = now;
        _showIssueReportDialog();
      }
    }
  }

  void _showIssueReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report an Issue'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Describe the issue you\'re experiencing...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement issue submission logic
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Issue reported successfully')),
                      );
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _proximitySensorSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Rides',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
