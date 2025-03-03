import '../../data/model/captain_home_hive_model.dart';
import '../../data/repository/captain_home_local_repository.dart';
import '../../data/repository/captain_home_remote_repository.dart';
import '../../domain/entity/captain_home_entity.dart';
import '../../domain/repository/captain_home_repository.dart';

class CaptainHomeRepositoryImpl implements CaptainHomeRepository {
  final CaptainHomeLocalRepository localRepo;
  final CaptainHomeRemoteRepository remoteRepo;

  CaptainHomeRepositoryImpl({required this.localRepo, required this.remoteRepo});

  @override
  Future<CaptainHomeEntity> fetchCaptainProfile() async {
    final apiModel = await remoteRepo.fetchCaptainProfile();

    final entity = CaptainHomeEntity(
      id: apiModel.id,
      firstName: apiModel.firstName,
      lastName: apiModel.lastName,
      phoneNumber: apiModel.phoneNumber,
      email: apiModel.email,
      profilePicture: apiModel.profilePicture ?? "",
      licensePicture: apiModel.licensePicture ?? "",
      theme: apiModel.theme ?? "light",
      totalEarnings: apiModel.totalEarnings ?? 0.0,
      rideCount: apiModel.rideCount ?? 0,
      totalDistance: apiModel.totalDistance ?? 0.0,
      vehicleName: apiModel.vehicleName ?? "Unknown",
      vehiclePlate: apiModel.vehiclePlate ?? "Unknown",
      vehicleType: apiModel.vehicleType ?? "Unknown",
      vehicleCapacity: apiModel.vehicleCapacity ?? 0,
    );

    await saveCaptainLocally(entity); // Cache profile locally
    return entity;
  }

  @override
  Future<void> updateCaptainProfile(Map<String, dynamic> updatedData) async {
    await remoteRepo.updateCaptainProfile(updatedData);
  }

  @override
  Future<void> uploadProfilePicture(String filePath) async {
    await remoteRepo.uploadProfilePicture(filePath);
  }

  @override
  Future<void> logoutCaptain() async {
    await remoteRepo.logoutCaptain();
    await clearLocalCaptain(); // Clear local cache on logout
  }

  @override
  Future<void> saveCaptainLocally(CaptainHomeEntity captain) async {
    final hiveModel = CaptainHomeHiveModel(
      id: captain.id,
      firstName: captain.firstName,
      lastName: captain.lastName,
      phoneNumber: captain.phoneNumber,
      email: captain.email,
      profilePicture: captain.profilePicture,
      licensePicture: captain.licensePicture,
      theme: captain.theme,
      totalEarnings: captain.totalEarnings,
      rideCount: captain.rideCount,
      totalDistance: captain.totalDistance,
      vehicleName: captain.vehicleName,
      vehiclePlate: captain.vehiclePlate,
      vehicleType: captain.vehicleType,
      vehicleCapacity: captain.vehicleCapacity,
    );
    await localRepo.saveCaptain(hiveModel);
  }

  @override
  Future<CaptainHomeEntity?> getLocalCaptain() async {
    final hiveModel = await localRepo.getCaptain();
    if (hiveModel == null) return null;

    return CaptainHomeEntity(
      id: hiveModel.id,
      firstName: hiveModel.firstName,
      lastName: hiveModel.lastName,
      phoneNumber: hiveModel.phoneNumber,
      email: hiveModel.email,
      profilePicture: hiveModel.profilePicture,
      licensePicture: hiveModel.licensePicture,
      theme: hiveModel.theme,
      totalEarnings: hiveModel.totalEarnings,
      rideCount: hiveModel.rideCount,
      totalDistance: hiveModel.totalDistance,
      vehicleName: hiveModel.vehicleName,
      vehiclePlate: hiveModel.vehiclePlate,
      vehicleType: hiveModel.vehicleType,
      vehicleCapacity: hiveModel.vehicleCapacity,
    );
  }

  @override
  Future<void> clearLocalCaptain() async {
    await localRepo.clearCaptain();
  }
}
