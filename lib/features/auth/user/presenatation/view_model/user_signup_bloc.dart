import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:uber_mobile_app_project/core/error/failure.dart';
import 'package:uber_mobile_app_project/features/auth/user/presenatation/view_model/user_signup_event.dart';
import 'package:uber_mobile_app_project/features/auth/user/presenatation/view_model/user_signup_state.dart';
import '../../data/model/user_api_model.dart';
import '../../domain/repository/user_repository.dart';

class UserSignupBloc extends Bloc<UserSignupEvent, UserSignupState> {
  final UserRepository userRepository;

  UserSignupBloc({required this.userRepository}) : super(UserSignupInitial()) {
    on<UserSignupRequestEvent>(_onSignup);
  }

  Future<void> _onSignup(
      UserSignupRequestEvent event,
      Emitter<UserSignupState> emit,
      ) async {
    emit(UserSignupLoading());

    try {
      Either<Failure, UserApiModel> result = await userRepository.signup(
        firstname: event.firstname,  // ✅ Ensure correct parameters
        lastname: event.lastname,
        phonenumber: event.phonenumber,
        email: event.email,
        password: event.password,
        image: event.image,
      );

      result.fold(
            (failure) => emit(UserSignupFailure(failure.message)),
            (_) => emit(UserSignupSuccess()),
      );
    } catch (e) {
      emit(UserSignupFailure("Unexpected error occurred"));
    }
  }
}
