import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entity/captain_entity.dart';
import '../../domain/repository/captain_repository.dart';

class CaptainSignupUseCase {
  final CaptainRepository repository;

  CaptainSignupUseCase({required this.repository});

  Future<Either<Failure, CaptainEntity>> call(Map<String, dynamic> captainData) {
    return repository.signupCaptain(captainData); // ✅ Fixed method name
  }
}
