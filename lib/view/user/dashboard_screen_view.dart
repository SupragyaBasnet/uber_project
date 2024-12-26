import 'package:flutter/material.dart';


class DashBoardScreenView extends StatelessWidget {
  const DashBoardScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyGo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedPaymentMethod = "Cash"; // Default payment method
  final TextEditingController _fareController = TextEditingController(); // Fare input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    'EasyGo',
    // style: TextStyle(color: Colors.white), // This line explicitly sets the title color to white
  ),
  backgroundColor: Colors.black, // Keeps the AppBar background black
  foregroundColor: Colors.white,
  elevation: 0, // Removes shadow for a flat design
),

      body: Column(
        children: [
          // Top Map Section
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
          // Bottom Input Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
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
                // Offer Fare Field
                Row(
                  children: [
                    const Icon(Icons.money, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _fareController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Offer your fare',
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Payment Method Section
                GestureDetector(
                  onTap: () => _showPaymentOptions(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.payment, color: Colors.green),
                            const SizedBox(width: 10),
                            Text(
                              'Payment Method: $_selectedPaymentMethod',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final offeredFare =
                        _fareController.text.isNotEmpty ? _fareController.text : 'N/A';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Searching for a driver...\nFare: ₹$offeredFare\nPayment: $_selectedPaymentMethod',
                        ),
                      ),
                    );
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

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Payment Method',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.money, color: Colors.green),
                title: const Text('Cash', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = "Cash";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.blue),
                title:
                    const Text('Online', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = "Online";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
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
          RideOption(icon: Icons.electric_car, label: 'EV Car'),

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
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label selected')),
        );
      },
      child: Container(
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
        foregroundColor: Colors.white,
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
            title: Text('EV Car Ride - Kalanki to New Road'),
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
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('Profile'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile clicked')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.blue),
            title: const Text('Change Password'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change Password clicked')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.blue),
            title: const Text('Logout'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out')),
              );
            },
          ),
        ],
      ),
    );
  }
}
