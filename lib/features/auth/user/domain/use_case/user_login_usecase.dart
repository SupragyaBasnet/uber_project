import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/model/user_api_model.dart';
import '../repository/user_repository.dart';


class UserLoginUseCase {
  final UserRepository repository;

  UserLoginUseCase(this.repository);

  Future<Either<Failure, UserApiModel>> call(String phonenumber, String password) async {
    return await repository.login(phonenumber, password);
  }
}
