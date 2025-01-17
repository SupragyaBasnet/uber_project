import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String phoneNumber;

  ForgotPasswordSuccess(this.phoneNumber);
}

class ForgotPasswordError extends ForgotPasswordState {
  final String errorMessage;

  ForgotPasswordError(this.errorMessage);
}

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final TextEditingController phoneController = TextEditingController();

  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  void sendOtp() {
    emit(ForgotPasswordLoading());
    final phoneNumber = phoneController.text.trim();
    if (phoneNumber.length != 10) {
      emit(ForgotPasswordError("Invalid phone number"));
      return;
    }
    emit(ForgotPasswordSuccess(phoneNumber));
  }
}
