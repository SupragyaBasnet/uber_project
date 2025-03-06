import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:uber_mobile_app_project/presentation/provider/ride_provider.dart';
import 'package:uber_mobile_app_project/presentation/screens/%20history_screen.dart';


class MockRideProvider extends Mock implements RideProvider {}

void main() {
  late MockRideProvider mockRideProvider;

  setUp(() {
    mockRideProvider = MockRideProvider();
  });

  testWidgets('3️⃣ Displays "No ride history" if empty', (WidgetTester tester) async {
    when(() => mockRideProvider.getRideHistory()).thenAnswer((_) async => []);

    await tester.pumpWidget(
      ChangeNotifierProvider<RideProvider>.value(
        value: mockRideProvider,
        child: MaterialApp(home: HistoryScreen()),
      ),
    );

    expect(find.text('No ride history found.'), findsOneWidget);
  });
}
