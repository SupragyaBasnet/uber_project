import 'package:dio/dio.dart';
import '../../../../../../app/constants/api_endpoints.dart';
import '../../../../../../core/error/exception.dart';
import '../../model/captain_api_model.dart';

abstract class CaptainRemoteDatasource {
  Future<CaptainApiModel> loginCaptain(String phonenumber, String password);
  Future<CaptainApiModel> registerCaptain(CaptainApiModel captain);
  Future<void> logoutCaptain();
}

class CaptainRemoteDatasourceImpl implements CaptainRemoteDatasource {
  final Dio dio;

  CaptainRemoteDatasourceImpl(this.dio);

  @override
  Future<CaptainApiModel> loginCaptain(String phonenumber, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.captainLogin,
        data: {
          "phonenumber": phonenumber,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        return CaptainApiModel.fromJson(response.data["captain"]);
      } else {
        throw ServerException(response.data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CaptainApiModel> registerCaptain(CaptainApiModel captain) async {
    try {
      final response = await dio.post(
        ApiEndpoints.captainRegister,
        data: captain.toJson(),
      );

      if (response.statusCode == 201) {
        return CaptainApiModel.fromJson(response.data["captain"]);
      } else {
        throw ServerException(response.data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logoutCaptain() async {
    try {
      await dio.get(ApiEndpoints.captainLogout);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
