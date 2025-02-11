import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entity/captain_entity.dart';

abstract class CaptainRepository {
  Future<Either<Failure, CaptainEntity>> loginCaptain(Map<String, dynamic> credentials);
  Future<Either<Failure, CaptainEntity>> signupCaptain(Map<String, dynamic> captainData);
}
