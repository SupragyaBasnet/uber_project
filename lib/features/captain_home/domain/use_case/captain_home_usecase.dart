import '../entity/captain_home_entity.dart';
import '../repository/captain_home_repository.dart';

class FetchCaptainProfileUseCase {
  final CaptainHomeRepository repository;

  FetchCaptainProfileUseCase({required this.repository});

  Future<CaptainHomeEntity> call() async {
    return await repository.fetchCaptainProfile();
  }
}

class UpdateCaptainProfileUseCase {
  final CaptainHomeRepository repository;

  UpdateCaptainProfileUseCase({required this.repository});

  Future<void> call(Map<String, dynamic> updatedData) async {
    return await repository.updateCaptainProfile(updatedData);
  }
}

class UploadCaptainProfilePictureUseCase {
  final CaptainHomeRepository repository;

  UploadCaptainProfilePictureUseCase({required this.repository});

  Future<void> call(String filePath) async {
    return await repository.uploadProfilePicture(filePath);
  }
}

class LogoutCaptainUseCase {
  final CaptainHomeRepository repository;

  LogoutCaptainUseCase({required this.repository});

  Future<void> call() async {
    return await repository.logoutCaptain();
  }
}

class SaveCaptainLocallyUseCase {
  final CaptainHomeRepository repository;

  SaveCaptainLocallyUseCase({required this.repository});

  Future<void> call(CaptainHomeEntity captain) async {
    return await repository.saveCaptainLocally(captain);
  }
}

class GetLocalCaptainUseCase {
  final CaptainHomeRepository repository;

  GetLocalCaptainUseCase({required this.repository});

  Future<CaptainHomeEntity?> call() async {
    return await repository.getLocalCaptain();
  }
}

class ClearLocalCaptainUseCase {
  final CaptainHomeRepository repository;

  ClearLocalCaptainUseCase({required this.repository});

  Future<void> call() async {
    return await repository.clearLocalCaptain();
  }
}
