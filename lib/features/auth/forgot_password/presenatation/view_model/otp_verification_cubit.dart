import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OtpVerificationState {}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationLoading extends OtpVerificationState {}

class OtpVerificationSuccess extends OtpVerificationState {}

class OtpVerificationError extends OtpVerificationState {
  final String errorMessage;

  OtpVerificationError(this.errorMessage);
}

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final TextEditingController otpController = TextEditingController();

  OtpVerificationCubit() : super(OtpVerificationInitial());

  void verifyOtp(String phoneNumber) {
    emit(OtpVerificationLoading());
    if (otpController.text.trim() != "1234") {
      emit(OtpVerificationError("Invalid OTP"));
      return;
    }
    emit(OtpVerificationSuccess());
  }
}
