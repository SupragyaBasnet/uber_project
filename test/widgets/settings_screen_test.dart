import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:uber_mobile_app_project/presentation/provider/setting_provider.dart';

import 'package:uber_mobile_app_project/presentation/screens/settings_screen.dart';

void main() {
  testWidgets('6️⃣ SettingsScreen toggles settings correctly', (WidgetTester tester) async {
    final settingsProvider = SettingsProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<SettingsProvider>.value(
        value: settingsProvider,
        child: MaterialApp(home: SettingsScreen()),
      ),
    );

    final darkModeSwitch = find.byType(Switch).first;
    final notificationSwitch = find.byType(Switch).last;

    await tester.tap(darkModeSwitch);
    await tester.pump();
    expect(settingsProvider.isDarkMode, true);

    await tester.tap(notificationSwitch);
    await tester.pump();
    expect(settingsProvider.notificationsEnabled, false);
  });
}
