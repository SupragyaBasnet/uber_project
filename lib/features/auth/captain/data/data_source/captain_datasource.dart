import '../../domain/entity/captain_entity.dart';
import '../data_source/local_datasource/captain_local_datasource.dart';
import '../data_source/remote_datasource/captain_remote_datasource.dart';
import '../model/captain_hive_model.dart';

abstract class CaptainDataSource {
  Future<CaptainEntity> loginCaptain(Map<String, dynamic> credentials);
  Future<CaptainEntity> registerCaptain(Map<String, dynamic> captainData);
  Future<void> cacheCaptainData(CaptainEntity captain);
  Future<CaptainEntity?> getCachedCaptainData();
  Future<void> clearCachedData();
}

class CaptainDataSourceImpl implements CaptainDataSource {
  final CaptainRemoteDataSource remoteDataSource;
  final CaptainLocalDataSource localDataSource;

  CaptainDataSourceImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<CaptainEntity> loginCaptain(Map<String, dynamic> credentials) async {
    final captainApiModel = await remoteDataSource.loginCaptain(credentials);
    final captainEntity = captainApiModel.toEntity();

    // ✅ Convert Entity to HiveModel before caching
    await localDataSource.cacheCaptainData(CaptainHiveModel.fromEntity(captainEntity));
    return captainEntity;
  }

  @override
  Future<CaptainEntity> registerCaptain(Map<String, dynamic> captainData) async {
    final captainApiModel = await remoteDataSource.registerCaptain(captainData);
    final captainEntity = captainApiModel.toEntity();

    // ✅ Convert Entity to HiveModel before caching
    await localDataSource.cacheCaptainData(CaptainHiveModel.fromEntity(captainEntity));
    return captainEntity;
  }

  @override
  Future<void> cacheCaptainData(CaptainEntity captain) async {
    // ✅ Convert Entity to HiveModel before caching
    await localDataSource.cacheCaptainData(CaptainHiveModel.fromEntity(captain));
  }

  @override
  Future<CaptainEntity?> getCachedCaptainData() async {
    final captainHiveModel = await localDataSource.getCachedCaptainData();

    // ✅ Convert HiveModel back to Entity before returning
    return captainHiveModel?.toEntity();
  }

  @override
  Future<void> clearCachedData() async {
    await localDataSource.clearCachedData();
  }
}
