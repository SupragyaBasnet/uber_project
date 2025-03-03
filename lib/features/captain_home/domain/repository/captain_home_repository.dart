import '../entity/captain_home_entity.dart';

abstract class CaptainHomeRepository {
  Future<CaptainHomeEntity> fetchCaptainProfile();
  Future<void> updateCaptainProfile(Map<String, dynamic> updatedData);
  Future<void> uploadProfilePicture(String filePath);
  Future<void> logoutCaptain();
  Future<void> saveCaptainLocally(CaptainHomeEntity captain);
  Future<CaptainHomeEntity?> getLocalCaptain();
  Future<void> clearLocalCaptain();
}
