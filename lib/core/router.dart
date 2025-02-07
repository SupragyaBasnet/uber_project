import 'package:flutter/material.dart';
import '../presentation/screens/ history_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/booking_screen.dart';
import '../presentation/screens/profile_screen.dart';
import '../presentation/screens/payment_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/screens/tracking_screen.dart';
import '../presentation/screens/ride_details_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/booking':
        return MaterialPageRoute(builder: (_) => BookingScreen());
      case '/history':
        return MaterialPageRoute(builder: (_) => HistoryScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/payment':
      // Ensure 'rideId' and 'amount' are passed correctly
        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null || !args.containsKey('rideId') || !args.containsKey('amount')) {
          return MaterialPageRoute(builder: (_) => const LoginScreen()); // Redirect if arguments are missing
        }
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(
            rideId: args['rideId'],
            amount: args['amount'],
          ),
        );
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/tracking':
        final args = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (_) => TrackingScreen(rideId: args?['rideId'] ?? ''),
        );
      case '/ride-details':
      // Ensure 'rideId' is passed correctly
        final args = settings.arguments as Map<String, String>?;
        if (args == null || !args.containsKey('rideId')) {
          return MaterialPageRoute(builder: (_) => const LoginScreen()); // Redirect if argument is missing
        }
        return MaterialPageRoute(
          builder: (_) => RideDetailsScreen(rideId: args['rideId']!),
        );
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
