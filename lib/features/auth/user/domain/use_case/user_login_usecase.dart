import 'package:dartz/dartz.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class UserLoginUseCase implements UsecaseWithParams<UserEntity, Map<String, dynamic>> {
  final UserRepository repository;

  UserLoginUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call(Map<String, dynamic> credentials) {
    return repository.loginUser(credentials);
  }
}
