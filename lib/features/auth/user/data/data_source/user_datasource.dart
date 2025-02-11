import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/data_source/remote_datasource/user_remote_datasource.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';

class UserAuthRepository implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserAuthRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> loginUser(Map<String, dynamic> credentials) async {
    try {
      final user = await remoteDataSource.loginUser(credentials);
      return Right(user.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signupUser(Map<String, dynamic> userData) async {
    try {
      final user = await remoteDataSource.signupUser(userData);
      return Right(user.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
