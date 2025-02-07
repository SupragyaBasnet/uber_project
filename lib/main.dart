import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_mobile_app_project/presentation/provider/payment_provider.dart';
import 'package:uber_mobile_app_project/presentation/provider/ride_provider.dart';
import 'core/router.dart';

import 'data/repositories/ride_repository.dart';
import 'domain/usecase/book_ride_usecase.dart';
import 'domain/usecase/get_rides_usecase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RideProvider(
            bookRideUseCase: BookRideUseCase(RideRepository()),
            getRidesUseCase: GetRidesUseCase(RideRepository()),
          ),
        ),
        ChangeNotifierProvider(create: (context) => PaymentProvider()), // ✅ Added PaymentProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ride App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
