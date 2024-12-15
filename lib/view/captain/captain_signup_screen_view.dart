import 'package:flutter/material.dart';
import '../user/login_screen_view.dart';
import '../user/signup_screen_view.dart'; // Import user signup screen
import 'captain_login_screen_view.dart'; // Import captain login screen

class CaptainSignupScreenView extends StatefulWidget {
  const CaptainSignupScreenView({super.key});

  @override
  _CaptainSignupScreenViewState createState() =>
      _CaptainSignupScreenViewState();
}

class _CaptainSignupScreenViewState extends State<CaptainSignupScreenView> {
  // Controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController vehicleColorController = TextEditingController();
  TextEditingController vehiclePlateController = TextEditingController();
  TextEditingController vehicleCapacityController = TextEditingController();

  // Dropdown value for vehicle type
  String? selectedVehicle;

  // Flag to toggle password visibility
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Go back to the previous screen
        ),
        title: const Text('Uber'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.05), // Dynamic padding based on screen size
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Captain's name input field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "What’s our Captain’s name",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name, // Alphabet keyboard for name input
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Captain's phone number input field
              TextField(
                controller: phonenumberController,
                decoration: InputDecoration(
                  labelText: "What’s our Captain’s Phone Number",
                  prefixText: '+977 ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone, // Numeric keyboard for phone number input
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Password input field with toggle for visibility
              TextField(
                controller: passwordController,
                obscureText: !_isPasswordVisible, // Toggle visibility
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.text, // Alphabet keyboard for password
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Vehicle Information Header
              const Text(
                "Vehicle Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Vehicle color input field
              TextField(
                controller: vehicleColorController,
                decoration: InputDecoration(
                  labelText: "Vehicle Color",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text, // Alphabet keyboard for vehicle color
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Vehicle plate input field
              TextField(
                controller: vehiclePlateController,
                decoration: InputDecoration(
                  labelText: "Vehicle Plate",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text, // Alphabet keyboard for vehicle plate
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Vehicle capacity input field
              TextField(
                controller: vehicleCapacityController,
                decoration: InputDecoration(
                  labelText: "Vehicle Capacity",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // Numeric keyboard for vehicle capacity
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Vehicle type dropdown
              DropdownButtonFormField<String>(
                value: selectedVehicle,
                decoration: InputDecoration(
                  labelText: "Select Vehicle",
                  border: OutlineInputBorder(),
                ),
                items: [
                  "Car",
                  "Bike",
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedVehicle = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Create account button
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      phonenumberController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      vehicleColorController.text.isEmpty ||
                      vehiclePlateController.text.isEmpty ||
                      vehicleCapacityController.text.isEmpty ||
                      selectedVehicle == null) {
                    // Show error message if any field is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please fill in all fields'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Account Created Successfully'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Navigate to captain login screen after success
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CaptainLoginScreenView(),
                        ),
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, screenHeight * 0.07), // Dynamic button height
                ),
                child: Text(
                  "Create Captain’s account",

                ),
              ),
              const SizedBox(height: 16),

              // Navigate to captain login screen
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CaptainLoginScreenView(),
                    ),
                  );
                },
                child: const Text(
                  "Already have an account ? Login here",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreenView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, screenHeight * 0.07), // Dynamic button height
                ),
                child: Text(
                  'Sign up as Passenger',
                  // style: TextStyle(
                  //   fontSize: screenWidth * 0.05, // Font size based on screen width
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
