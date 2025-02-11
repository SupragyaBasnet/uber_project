import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> loginUser(Map<String, dynamic> credentials);
  Future<Either<Failure, UserEntity>> signupUser(Map<String, dynamic> userData);
}
