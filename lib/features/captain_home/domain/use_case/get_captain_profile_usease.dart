import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entity/captain_home_entity.dart';
import '../repository/captain_home_repository.dart';

class GetCaptainProfileUseCase {
  final CaptainHomeRepository repository;

  GetCaptainProfileUseCase({required this.repository});

  Future<Either<Failure, CaptainHomeEntity>> call(String captainId) async {
    try {
      final captain = await repository.fetchCaptainProfile();
      return Right(captain); // ✅ Wrap in Either.Right
    } catch (e) {
      return Left(ServerFailure(e.toString())); // ✅ Wrap in Either.Left on error
    }
  }
}
