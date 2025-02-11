import 'package:hive/hive.dart';
import '../../model/captain_hive_model.dart';

abstract class CaptainLocalDataSource {
  Future<void> cacheCaptainData(CaptainHiveModel captain);
  Future<CaptainHiveModel?> getCachedCaptainData();
  Future<void> clearCachedData();
}

class CaptainLocalDataSourceImpl implements CaptainLocalDataSource {
  final Box<CaptainHiveModel> captainBox;

  CaptainLocalDataSourceImpl(this.captainBox);

  @override
  Future<void> cacheCaptainData(CaptainHiveModel captain) async {
    await captainBox.put('captain', captain);
  }

  @override
  Future<CaptainHiveModel?> getCachedCaptainData() async {
    return captainBox.get('captain');
  }

  @override
  Future<void> clearCachedData() async {
    await captainBox.delete('captain');
  }
}
