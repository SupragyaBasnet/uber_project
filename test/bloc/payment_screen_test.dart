import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uber_mobile_app_project/presentation/screens/payment_screen.dart';

void main() {
  testWidgets('7️⃣ PaymentScreen displays UI elements', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PaymentScreen(rideId: '1', amount: 50.0),
    ));

    expect(find.text('Amount to Pay: \$50.0'), findsOneWidget);
    expect(find.text('Confirm Payment'), findsOneWidget);
  });
}
