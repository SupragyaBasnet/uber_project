import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/model/captain_api_model.dart';
import '../../domain/repository/captain_repository_impl.dart';
import 'captain_upload_image_usecase.dart';

class CaptainSignupUseCase {
  final CaptainRepository repository;

  CaptainSignupUseCase(this.repository);

  Future<Either<Failure, CaptainApiModel>> call(CaptainApiModel captain) async {
    return await repository.signup(captain);
  }
}
