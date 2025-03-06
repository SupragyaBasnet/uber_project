import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:uber_mobile_app_project/data/models/ride_model.dart';
import 'package:uber_mobile_app_project/presentation/provider/ride_provider.dart';

import 'package:uber_mobile_app_project/presentation/screens/ride_details_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockRideProvider extends Mock implements RideProvider {}

void main() {
  late MockRideProvider mockRideProvider;

  setUp(() {
    mockRideProvider = MockRideProvider();
  });

  final mockRide = Ride(
    id: '1',
    driverName: 'John Doe',
    pickupLocation: 'A',
    dropoffLocation: 'B',
    fare: 20.0,
    status: 'confirmed',
    date: DateTime.now(),
    driverLatitude: 27.7172,
    driverLongitude: 85.3240,
  );

  testWidgets('4️⃣ RideDetailsScreen displays correct ride info', (WidgetTester tester) async {
    when(() => mockRideProvider.getRideById(any())).thenReturn(mockRide);

    await tester.pumpWidget(
      ChangeNotifierProvider<RideProvider>.value(
        value: mockRideProvider,
        child: const MaterialApp(home: RideDetailsScreen(rideId: '1')),
      ),
    );

    expect(find.text('Driver: John Doe'), findsOneWidget);
    expect(find.text('Pickup: A'), findsOneWidget);
    expect(find.text('Destination: B'), findsOneWidget);
    expect(find.text('Fare: \$20.0'), findsOneWidget);
  });
}
