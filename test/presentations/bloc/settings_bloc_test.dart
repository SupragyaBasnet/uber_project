import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:uber_mobile_app_project/bloc/settings_bloc.dart';


void main() {
  group('SettingsBloc Tests', () {
    blocTest<SettingsBloc, SettingsState>(
      '✅ emits updated state when Dark Mode toggled',
      build: () => SettingsBloc(),
      act: (bloc) => bloc.add(ToggleDarkModeEvent()),
      expect: () => [SettingsState(isDarkMode: true, notificationsEnabled: true)],
    );

    blocTest<SettingsBloc, SettingsState>(
      '✅ emits updated state when Notifications toggled',
      build: () => SettingsBloc(),
      act: (bloc) => bloc.add(ToggleNotificationsEvent()),
      expect: () => [SettingsState(isDarkMode: false, notificationsEnabled: false)],
    );
  });
}
