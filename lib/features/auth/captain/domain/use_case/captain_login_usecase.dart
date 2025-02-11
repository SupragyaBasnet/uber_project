import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

import '../../data/model/captain_api_model.dart';
import '../repository/captain_repository_impl.dart';

import 'captain_upload_image_usecase.dart';

class CapatainLoginUseCase {
  final CaptainRepository repository;

  CapatainLoginUseCase(this.repository);

  Future<Either<Failure, CaptainApiModel>> call(String phonenumber, String password) async {
    return await repository.login(phonenumber, password);
  }
}
