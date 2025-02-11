import 'package:dio/dio.dart';
import '../../model/captain_api_model.dart';

abstract class CaptainRemoteDataSource {
  Future<CaptainApiModel> loginCaptain(Map<String, dynamic> credentials);
  Future<CaptainApiModel> registerCaptain(Map<String, dynamic> captainData); // ✅ Ensure this exists
}
class CaptainRemoteDataSourceImpl implements CaptainRemoteDataSource {
  final Dio dio;

  CaptainRemoteDataSourceImpl(this.dio);

  @override
  Future<CaptainApiModel> loginCaptain(Map<String, dynamic> credentials) async {
    final response = await dio.post('/captain/login', data: credentials);
    return CaptainApiModel.fromJson(response.data);
  }

  @override
  Future<CaptainApiModel> registerCaptain(Map<String, dynamic> captainData) async { // ✅ Fixed
    final response = await dio.post('/captain/signup', data: captainData);
    return CaptainApiModel.fromJson(response.data);
  }
}
