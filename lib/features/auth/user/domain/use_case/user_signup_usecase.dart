import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/model/user_api_model.dart';
import '../repository/user_repository.dart';

class UserSignupUseCase {
  final UserRepository repository;

  UserSignupUseCase(this.repository);


  /// ✅ **Fixed: Pass parameters directly to `signup()`**
  Future<Either<Failure, UserApiModel>> call({
    required String firstname,
    required String lastname,
    required String phonenumber,
    required String email,
    required String password,
    File? image, // ✅ Keep it File, let repo handle upload
  }) async {
    return await repository.signup(
      firstname: firstname,
      lastname: lastname,
      phonenumber: phonenumber,
      email: email,
      password: password,
      image: image, // ✅ Correct parameter passing
    );
  }
}
