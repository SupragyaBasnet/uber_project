import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../../app/constants/api_endpoints.dart';
import '../../../../../core/error/failure.dart';
import '../model/captain_api_model.dart';

class CaptainRemoteRepository {
  final Dio dio;

  CaptainRemoteRepository(this.dio);

  /// 🔹 Captain Login API Call
  Future<Either<Failure, CaptainApiModel>> login(String phonenumber, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.captainLogin,
        data: {
          "phonenumber": phonenumber,
          "password": password,
        },
      );

      return Right(CaptainApiModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioError(e));
    }
  }

  /// 🔹 Captain Signup API Call
  Future<Either<Failure, CaptainApiModel>> signup(CaptainApiModel captain) async {
    try {
      final response = await dio.post(
        ApiEndpoints.captainRegister,
        data: captain.toJson(),
      );

      return Right(CaptainApiModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioError(e));
    }
  }

  /// 🔹 Fetch Captain Profile
  Future<Either<Failure, CaptainApiModel>> getCaptainProfile(String token) async {
    try {
      final response = await dio.get(
        ApiEndpoints.captainProfile,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return Right(CaptainApiModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioError(e));
    }
  }

  /// 🔹 Logout API Call
  Future<Either<Failure, void>> logout(String token) async {
    try {
      await dio.get(
        ApiEndpoints.captainLogout,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioError(e));
    }
  }

  /// 🔹 Upload Image API Call
  Future<Either<Failure, String>> uploadImage(File image) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path),
      });

      final response = await dio.post(
        ApiEndpoints.uploadCaptainImage,
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      return Right(response.data['imageUrl']); // Image URL returned from API
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioError(e));
    }
  }
}
