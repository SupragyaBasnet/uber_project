import 'package:flutter/material.dart';
import 'package:uber_project/view/user/dashboard/ride_history_screen_view.dart';
import 'package:uber_project/view/user/dashboard/settings_screen_view.dart';

import 'home_screen_view.dart';


class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({super.key});

  @override
  _DashboardScreenViewState createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreenView(),
    const RideHistoryScreenView(),
    const SettingsScreenView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Ride History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
