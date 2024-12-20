import 'package:flutter/material.dart';

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreenView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const RidesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Rides',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
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
        foregroundColor:Colors.white
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
                const Text(
                  'Find a Trip',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:Colors.green),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a pick-up location',
                    // filled: true,
                    fillColor: Colors.grey[600],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your destination',
                    // filled: true,
                    fillColor: Colors.grey[600],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    padding: const EdgeInsets.all(16),
                    foregroundColor:Colors.black,
                  ),
                  child: const Text('Request a Ride'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rides'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text("Ashish Marga, Nirmala's Kitchen, Dumbarahi"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text("Ashish Marga, Nirmala's Kitchen, Dumbarahi"),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'john.doe@example.com',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
