import 'package:flutter/material.dart';
import '../../../../../app/usecase/usecase.dart';
import '../repository/user_repository.dart';

class LoginUserUseCase extends UseCase<bool, LoginParams> {
  final UserRepository repository;

  LoginUserUseCase(this.repository);

  @override
  Future<bool> call(LoginParams params) async {
    final user = await repository.login(params.phoneNumber, params.password);
    return user != null; // Return true if a User is found, false otherwise
  }
}

class LoginParams {
  final String phoneNumber;
  final String password;

  LoginParams({
    required this.phoneNumber,
    required this.password,
  });
}
