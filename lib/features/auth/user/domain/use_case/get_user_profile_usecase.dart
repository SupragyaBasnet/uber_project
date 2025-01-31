import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

import '../../data/model/user_api_model.dart';
import '../repository/user_repository.dart';


class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Either<Failure, UserApiModel>> call() async {
    return await repository.getUserProfile();
  }
}
