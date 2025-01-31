import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/core/network/api_service.dart';
import 'package:uber_mobile_app_project/features/auth/user/domain/repository/user_repository.dart';
import 'user_login_event.dart';
import 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final ApiService apiService;

  UserLoginBloc({required this.apiService, required UserRepository userRepository}) : super(UserLoginInitial()) {
    on<UserLoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    UserLoginSubmitted event,
    Emitter<UserLoginState> emit,
  ) async {
    emit(UserLoginLoading());

    try {
      final response = await apiService.userLogin(
        event.phonenumber,
        event.password,
      );

      if (response.containsKey("token")) {
        emit(UserLoginSuccess(
          token: response["token"],
          userId: response["user"]["_id"],
        ));
      } else {
        emit(UserLoginFailure(message: "Login failed. Please try again."));
      }
    } catch (e) {
      emit(UserLoginFailure(message: "Network error. Please check your connection."));
    }
  }
}
