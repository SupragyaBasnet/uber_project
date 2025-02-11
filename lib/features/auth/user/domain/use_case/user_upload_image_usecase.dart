import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:uber_mobile_app_project/core/error/failure.dart';
import 'package:uber_mobile_app_project/features/auth/user/domain/repository/user_repository.dart';

import '../../../../../app/usecase/usecase.dart';


class UploadImageParams {
  final File file;

  const UploadImageParams({required this.file});
}

class UploadUserImageUseCase implements UsecaseWithParams<String, UploadImageParams> {
  final UserRepository _repository;

  UploadUserImageUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _repository.uploadImage(params.file);
  }
}
