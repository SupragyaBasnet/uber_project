import 'package:hive/hive.dart';
import '../../../../../../app/constants/hive_table_constant.dart';

import '../../model/captain_hive_model.dart';

abstract class CaptainLocalDatasource {
  Future<void> cacheCaptainData(CaptainHiveModel captain);
  Future<CaptainHiveModel?> getCachedCaptain();
  Future<void> clearCaptainData();
}

class CaptainLocalDatasourceImpl implements CaptainLocalDatasource {
  final Box _captainBox;

  CaptainLocalDatasourceImpl(this._captainBox);

  @override
  Future<void> cacheCaptainData(CaptainHiveModel captain) async {
    await _captainBox.put(HiveTableConstants.captainBox, captain);
  }

  @override
  Future<CaptainHiveModel?> getCachedCaptain() async {
    return _captainBox.get(HiveTableConstants.captainBox);
  }

  @override
  Future<void> clearCaptainData() async {
    await _captainBox.delete(HiveTableConstants.captainBox);
  }
}
