import '../../../../../app/usecase/usecase.dart';
import '../../data/model/captain_model.dart';
import '../repository/captain_repository.dart';

class RegisterCaptainUseCase extends UseCase<void, CaptainRegisterParams> {
  final CaptainRepository repository;

  RegisterCaptainUseCase(this.repository);

  @override
  Future<void> call(CaptainRegisterParams params) async {
    final captain = CaptainModel(
      phoneNumber: params.phoneNumber,
      password: params.password,
    );
    return await repository.register(captain);
  }
}

class CaptainRegisterParams {
  final String phoneNumber;
  final String password;

  CaptainRegisterParams({
    required this.phoneNumber,
    required this.password,
  });
}
