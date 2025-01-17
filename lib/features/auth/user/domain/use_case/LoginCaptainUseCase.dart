import '../../../../../app/usecase/usecase.dart';
import '../repository/captain_repository.dart';

class LoginCaptainUseCase extends UseCase<bool, CaptainLoginParams> {
  final CaptainRepository repository;

  LoginCaptainUseCase(this.repository);

  @override
  Future<bool> call(CaptainLoginParams params) async {
    final captain = await repository.login(params.phoneNumber, params.password);
    return captain != null; // Return true if a Captain is found, false otherwise
  }
}

class CaptainLoginParams {
  final String phoneNumber;
  final String password;

  CaptainLoginParams({
    required this.phoneNumber,
    required this.password,
  });
}
