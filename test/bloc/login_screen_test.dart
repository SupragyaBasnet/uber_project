import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uber_mobile_app_project/presentation/screens/login_screen.dart';

void main() {
  testWidgets('9️⃣ LoginScreen UI is displayed correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
