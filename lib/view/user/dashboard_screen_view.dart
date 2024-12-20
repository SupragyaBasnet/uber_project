import 'package:flutter/material.dart';

void main() => runApp(const EasyGoApp());

class EasyGoApp extends StatelessWidget {
  const EasyGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyGo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          // bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.white70),
        ),
      ),
      home: const DashboardScreenView(),
    );
  }
}

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({super.key});

  @override
  _DashboardScreenViewState createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const RideHistoryScreen(),
    const SettingsScreen(),
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
        backgroundColor: Colors.black,
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyGo'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const RideOptionsRow(),
                const SizedBox(height: 16),
                const CustomInputField(
                  icon: Icons.location_on,
                  hintText: 'Deep Jyoti Marg (Dhumbarahi)',
                  inputType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 16),
                const CustomInputField(
                  icon: Icons.search,
                  hintText: 'Enter your destination',
                  inputType: TextInputType.text,
                ),
                const SizedBox(height: 16),
                const CustomInputField(
                  icon: Icons.money,
                  hintText: 'Offer your fare',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle finding driver logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    'Find a Driver',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RideOptionsRow extends StatelessWidget {
  const RideOptionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          RideOption(icon: Icons.motorcycle, label: 'Bike'),
          RideOption(icon: Icons.directions_car, label: 'Car'),
          RideOption(icon: Icons.auto_awesome, label: 'Autorickshaw'),
        ],
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextInputType inputType;

  const CustomInputField({
    required this.icon,
    required this.hintText,
    required this.inputType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            keyboardType: inputType,
            decoration: InputDecoration(
              hintText: hintText,
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class RideOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const RideOption({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[800],
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride History'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: Icon(Icons.motorcycle, color: Colors.blue),
            title: Text('Bike Ride - Deep Jyoti Marg to Baneshwor'),
            subtitle: Text('Completed on 12 Dec, 2024'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.directions_car, color: Colors.blue),
            title: Text('Car Ride - Baluwatar to Thamel'),
            subtitle: Text('Completed on 10 Dec, 2024'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.auto_awesome, color: Colors.blue),
            title: Text('Autorickshaw Ride - Kalanki to New Road'),
            subtitle: Text('Completed on 8 Dec, 2024'),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('Profile'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.blue),
            title: const Text('Change Password'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.blue),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
