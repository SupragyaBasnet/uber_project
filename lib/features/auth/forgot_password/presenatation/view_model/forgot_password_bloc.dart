import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/use_case/forgot_password_usecase.dart';
import '../../domain/entity/forgot_password_entity.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase useCase;

  ForgotPasswordBloc({required this.useCase}) : super(ForgotPasswordInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onSendOtp(SendOtpEvent event,
      Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());

    try {
      final message = await useCase.sendOtp(
        ForgotPasswordEntity(
            email: event.email, userType: event.userType), // ✅ Added `userType`
      );
      emit(OtpSentState(message));
    } catch (e) {
      emit(ForgotPasswordError("Failed to send OTP."));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event,
      Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());

    try {
      final message = await useCase.verifyOtp(
        ForgotPasswordEntity(email: event.email,
            otp: event.otp,
            userType: event.userType), // ✅ Added `userType`
      );
      emit(OtpVerifiedState(message));
    } catch (e) {
      emit(ForgotPasswordError("Invalid or expired OTP."));
    }
  }

  Future<void> _onResetPassword(ResetPasswordEvent event,
      Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());

    if (event.newPassword != event.confirmPassword) {
      emit(ForgotPasswordError("Passwords do not match."));
      return;
    }

    try {
      final message = await useCase.resetPassword(
        ForgotPasswordEntity(
          email: event.email,
          otp: event.otp,
          newPassword: event.newPassword,
          userType: event.userType, // ✅ Added `userType`
        ),
      );
      emit(PasswordResetSuccess(message));
    } catch (e) {
      emit(ForgotPasswordError("Failed to reset password."));
    }
  }

}