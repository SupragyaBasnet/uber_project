import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uber_mobile_app_project/presentation/screens/tracking_screen.dart';

void main() {
  testWidgets('5️⃣ TrackingScreen initializes correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TrackingScreen(rideId: '1')));

    expect(find.text("Ride Tracking"), findsOneWidget);
  });
}
