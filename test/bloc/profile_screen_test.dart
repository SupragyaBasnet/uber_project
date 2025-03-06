import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uber_mobile_app_project/presentation/screens/profile_screen.dart';

void main() {
  testWidgets('8️⃣ ProfileScreen contains necessary fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Update Profile'), findsOneWidget);
  });
}
