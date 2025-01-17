import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/RegisterUserUseCase.dart';
import 'user_signup_event.dart';
import 'user_signup_state.dart';

class UserSignupBloc extends Bloc<UserSignupEvent, UserSignupState> {
  final RegisterUserUseCase registerUserUseCase;

  UserSignupBloc(this.registerUserUseCase) : super(UserSignupInitial());

  @override
  Stream<UserSignupState> mapEventToState(UserSignupEvent event) async* {
    if (event is UserSignupSubmit) {
      yield UserSignupLoading();

      try {
        await registerUserUseCase(
          RegisterParams(
            phoneNumber: event.phoneNumber,
            password: event.password,
          ),
        );
        yield UserSignupSuccess();
      } catch (e) {
        yield UserSignupError("Failed to create an account. Please try again.");
      }
    }
  }
}
