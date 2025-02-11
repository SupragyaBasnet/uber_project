import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/data_source/remote_datasource/captain_remote_datasource.dart';
import '../../domain/entity/captain_entity.dart';
import '../../domain/repository/captain_repository.dart';

class CaptainAuthRepository implements CaptainRepository {
  final CaptainRemoteDataSource remoteDataSource;

  CaptainAuthRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, CaptainEntity>> loginCaptain(Map<String, dynamic> credentials) async {
    try {
      final captain = await remoteDataSource.loginCaptain(credentials);
      return Right(captain.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CaptainEntity>> signupCaptain(Map<String, dynamic> captainData) async {
    try {
      final captain = await remoteDataSource.registerCaptain(captainData);
      return Right(captain.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
