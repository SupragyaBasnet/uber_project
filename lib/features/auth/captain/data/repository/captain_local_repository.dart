import '../../domain/entity/captain_entity.dart';
import '../data_source/local_datasource/captain_local_datasource.dart';
import '../model/captain_hive_model.dart';

class CaptainLocalRepository {
  final CaptainLocalDataSource localDataSource;

  CaptainLocalRepository(this.localDataSource);

  Future<void> cacheCaptain(CaptainEntity captain) async {
    await localDataSource.cacheCaptainData(CaptainHiveModel.fromEntity(captain));
  }

  Future<CaptainEntity?> getCachedCaptain() async {
    final data = await localDataSource.getCachedCaptainData();
    return data?.toEntity(); // ✅ Convert Hive model to entity
  }

  Future<void> clearCachedData() async {
    await localDataSource.clearCachedData();
  }
}
