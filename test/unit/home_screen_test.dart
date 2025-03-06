import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:uber_mobile_app_project/presentation/provider/ride_provider.dart';

import 'package:uber_mobile_app_project/presentation/screens/home_screen.dart';

// Mock Ride Provider
class MockRideProvider extends Mock implements RideProvider {}

void main() {
  late MockRideProvider mockRideProvider;

  setUp(() {
    mockRideProvider = MockRideProvider();
  });

  testWidgets('1️⃣ HomeScreen loads correctly', (WidgetTester tester) async {
    when(() => mockRideProvider.isLoading).thenReturn(false);
    when(() => mockRideProvider.rides).thenReturn([]);
    
    await tester.pumpWidget(
      ChangeNotifierProvider<RideProvider>.value(
        value: mockRideProvider,
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.text('RideApp - Home'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
