import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/LoginCaptainUseCase.dart';

import 'captain_login_event.dart';
import 'captain_login_state.dart';

class CaptainLoginBloc extends Bloc<CaptainLoginEvent, CaptainLoginState> {
  final LoginCaptainUseCase loginCaptainUseCase;

  CaptainLoginBloc(this.loginCaptainUseCase) : super(CaptainLoginInitial());

  @override
  Stream<CaptainLoginState> mapEventToState(CaptainLoginEvent event) async* {
    if (event is CaptainLoginSubmit) {
      yield CaptainLoginLoading();

      try {
        final success = await loginCaptainUseCase(
          CaptainLoginParams(
            phoneNumber: event.phoneNumber,
            password: event.password,
          ),
        );

        if (success) {
          yield CaptainLoginSuccess();
        } else {
          yield CaptainLoginError("Invalid credentials");
        }
      } catch (e) {
        yield CaptainLoginError("An error occurred. Please try again.");
      }
    }
  }
}
