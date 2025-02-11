import 'package:dartz/dartz.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../../../../core/error/failure.dart';
import '../entity/captain_entity.dart';
import '../repository/captain_repository.dart';

class CaptainLoginUseCase implements UsecaseWithParams<CaptainEntity, Map<String, dynamic>> {
  final CaptainRepository repository;

  CaptainLoginUseCase({required this.repository});

  @override
  Future<Either<Failure, CaptainEntity>> call(Map<String, dynamic> credentials) {
    return repository.loginCaptain(credentials);
  }
}
