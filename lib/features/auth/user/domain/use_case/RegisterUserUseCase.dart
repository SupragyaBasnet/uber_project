import '../../../../../app/usecase/usecase.dart';
import '../../data/model/user_model.dart';
import '../repository/user_repository.dart';


class RegisterUserUseCase extends UseCase<void, RegisterParams> {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  @override
  Future<void> call(RegisterParams params) async {
    final user = UserModel(
      phoneNumber: params.phoneNumber,
      password: params.password,
    );
    return await repository.register(user);
  }
}

class RegisterParams {
  final String phoneNumber;
  final String password;

  RegisterParams({
    required this.phoneNumber,
    required this.password,
  });
}
