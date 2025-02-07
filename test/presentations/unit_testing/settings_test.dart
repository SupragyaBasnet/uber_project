import 'package:flutter_test/flutter_test.dart';
import 'package:uber_mobile_app_project/presentation/provider/setting_provider.dart';


void main() {
  late SettingsProvider settingsProvider;

  setUp(() {
    settingsProvider = SettingsProvider();
  });

  test('7️⃣ Should toggle dark mode successfully', () {
    expect(settingsProvider.isDarkMode, false);

    settingsProvider.toggleDarkMode();
    expect(settingsProvider.isDarkMode, true);

    settingsProvider.toggleDarkMode();
    expect(settingsProvider.isDarkMode, false);
  });

  test('8️⃣ Should enable and disable notifications', () {
    expect(settingsProvider.notificationsEnabled, true);

    settingsProvider.toggleNotifications();
    expect(settingsProvider.notificationsEnabled, false);

    settingsProvider.toggleNotifications();
    expect(settingsProvider.notificationsEnabled, true);
  });
}
