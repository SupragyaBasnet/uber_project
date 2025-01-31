import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../data/model/captain_api_model.dart';
import '../repository/captain_repository_impl.dart';
import 'captain_upload_image_usecase.dart';


class GetCaptainProfileUseCase {
  final CaptainRepository repository;

  GetCaptainProfileUseCase(this.repository);

  Future<Either<Failure, CaptainApiModel>> call() async {
    return await repository.getCaptainProfile();
  }
}
