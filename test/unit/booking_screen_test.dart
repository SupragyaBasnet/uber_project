import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uber_mobile_app_project/presentation/screens/booking_screen.dart';

void main() {
  testWidgets('2️⃣ BookingScreen contains form fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BookingScreen()));

    expect(find.text('Pickup Location'), findsOneWidget);
    expect(find.text('Dropoff Location'), findsOneWidget);
    expect(find.text('Confirm Booking'), findsOneWidget);
  });
}
