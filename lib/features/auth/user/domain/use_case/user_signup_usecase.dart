import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class UserSignupUseCase {
  final UserRepository repository;

  UserSignupUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call(Map<String, dynamic> userData) {
    return repository.signupUser(userData);
  }
}
