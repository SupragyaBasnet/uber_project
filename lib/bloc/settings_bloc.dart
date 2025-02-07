import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

/// **Events**
abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleDarkModeEvent extends SettingsEvent {}

class ToggleNotificationsEvent extends SettingsEvent {}

/// **States**
class SettingsState extends Equatable {
  final bool isDarkMode;
  final bool notificationsEnabled;

  SettingsState({required this.isDarkMode, required this.notificationsEnabled});

  @override
  List<Object?> get props => [isDarkMode, notificationsEnabled];
}

/// **BLoC Implementation**
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState(isDarkMode: false, notificationsEnabled: true)) {
    on<ToggleDarkModeEvent>((event, emit) {
      emit(SettingsState(isDarkMode: !state.isDarkMode, notificationsEnabled: state.notificationsEnabled));
    });

    on<ToggleNotificationsEvent>((event, emit) {
      emit(SettingsState(isDarkMode: state.isDarkMode, notificationsEnabled: !state.notificationsEnabled));
    });
  }
}
