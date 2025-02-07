import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model.dart';

/// **Events**
abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends UserEvent {
  final String email;
  final String password;
  LoginUserEvent({required this.email, required this.password});
}

class LogoutUserEvent extends UserEvent {}

/// **States**
abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserAuthenticated extends UserState {
  final User user;
  UserAuthenticated({required this.user});
}

class UserLoggedOut extends UserState {}

class UserError extends UserState {
  final String message;
  UserError({required this.message});
}

/// **BLoC Implementation**
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<LoginUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final User? user = await userRepository.login(event.email, event.password);

        if (user == null) {
          emit(UserError(message: "Invalid credentials."));
        } else {
          emit(UserAuthenticated(user: user));
        }
      } catch (e) {
        emit(UserError(message: e.toString()));
      }
    });

    on<LogoutUserEvent>((event, emit) async {
      emit(UserLoading());
      await userRepository.logout();
      emit(UserLoggedOut());
    });
  }
}
