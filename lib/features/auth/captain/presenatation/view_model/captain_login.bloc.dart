import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/core/network/api_service.dart';
import 'package:uber_mobile_app_project/features/auth/captain/domain/repository/captain_repository.dart';
import 'captain_login_event.dart';
import 'captain_login_state.dart';

class CaptainLoginBloc extends Bloc<CaptainLoginEvent, CaptainLoginState> {
  final ApiService apiService;

  CaptainLoginBloc({required this.apiService, required CaptainRepository captainRepository}) : super(CaptainLoginInitial()) {
    on<CaptainLoginRequestEvent>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      CaptainLoginRequestEvent event,
      Emitter<CaptainLoginState> emit,
      ) async {
    emit(CaptainLoginLoading());

    try {
      final response = await apiService.captainLogin(
        event.phonenumber,
        event.password,
      );

      if (response.containsKey("token") && response.containsKey("captain")) {
        emit(CaptainLoginSuccess(
          token: response["token"],
          captainId: response["captain"]["_id"],
        ));
      } else {
        emit(CaptainLoginFailure(message: "Invalid credentials. Please try again."));
      }
    } catch (e) {
      emit(CaptainLoginFailure(message: "Network error. Please check your connection."));
    }
  }
}
