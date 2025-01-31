import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_mobile_app_project/core/network/api_service.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ApiService apiService;

  ForgotPasswordBloc({required this.apiService}) : super(ForgotPasswordInitial()) {
    on<SendOtpEvent>(_sendOtp);
    on<VerifyOtpEvent>(_verifyOtp);
    on<ResetPasswordEvent>(_resetPassword);
  }

  /// **Step 1: Send OTP**
  Future<void> _sendOtp(SendOtpEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try {
      final message = await apiService.sendOtp(event.email, event.userType);
      emit(ForgotPasswordSuccess(message: message, nextStep: 2));
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  /// **Step 2: Verify OTP**
  Future<void> _verifyOtp(VerifyOtpEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try {
      final message = await apiService.verifyOtp(event.email, event.otp);
      emit(ForgotPasswordSuccess(message: message, nextStep: 3));
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  /// **Step 3: Reset Password**
  Future<void> _resetPassword(ResetPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try {
      if (event.newPassword != event.confirmPassword) {
        emit(ForgotPasswordFailure("Passwords do not match!"));
        return;
      }

      final message = await apiService.resetPassword(
        email: event.email,
        otp: event.otp,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword, // ✅ Now correctly passing confirmPassword
        userType: event.userType,
      );

      emit(ForgotPasswordSuccess(message: message, nextStep: 1));
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}
