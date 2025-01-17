import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SetPasswordState {}

class SetPasswordInitial extends SetPasswordState {}

class SetPasswordLoading extends SetPasswordState {}

class SetPasswordSuccess extends SetPasswordState {}

class SetPasswordError extends SetPasswordState {
  final String errorMessage;

  SetPasswordError(this.errorMessage);
}

class SetPasswordCubit extends Cubit<SetPasswordState> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SetPasswordCubit() : super(SetPasswordInitial());

  void resetPassword(String phoneNumber) {
    emit(SetPasswordLoading());
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      emit(SetPasswordError("Passwords do not match"));
      return;
    }
    emit(SetPasswordSuccess());
  }
}
