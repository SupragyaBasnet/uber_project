import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/LoginUserUseCase.dart';
import 'user_login_event.dart';
import 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final LoginUserUseCase loginUserUseCase;

  UserLoginBloc(this.loginUserUseCase) : super(UserLoginInitial()) {
    // Register event handler for UserLoginSubmit
    on<UserLoginSubmit>((event, emit) async {
      emit(UserLoginLoading());

      try {
        final success = await loginUserUseCase(
          LoginParams(
            phoneNumber: event.phoneNumber,
            password: event.password,
          ),
        );

        if (success) {
          emit(UserLoginSuccess());
        } else {
          emit(UserLoginError("Invalid credentials"));
        }
      } catch (e) {
        emit(UserLoginError("An error occurred. Please try again."));
      }
    });
  }
}
