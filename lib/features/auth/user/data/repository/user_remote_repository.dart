import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../../app/constants/api_endpoints.dart';
import '../../../../../core/error/failure.dart';
import '../model/user_api_model.dart';

import 'package:dartz/dartz.dart';

class UserRemoteRepository {
  final Dio dio;

  UserRemoteRepository(this.dio);

  /// User Login API Call
  Future<Either<Failure, UserApiModel>> login(String phonenumber, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.userLogin,
        data: {
          "phonenumber": phonenumber,
          "password": password,
        },
      );

      return Right(UserApiModel.fromJson(response.data));
    } catch (e) {
      return Left(ApiFailure(message: "Login failed: ${e.toString()}"));
    }
  }

  /// User Signup API Call
  Future<Either<Failure, UserApiModel>> signup(UserApiModel user) async {
    try {
      final response = await dio.post(
        ApiEndpoints.userRegister,
        data: user.toJson(),
      );

      return Right(UserApiModel.fromJson(response.data));
    } catch (e) {
      return Left(ApiFailure(message: "Signup failed: ${e.toString()}"));
    }
  }

  /// Fetch User Profile
  Future<Either<Failure, UserApiModel>> getUserProfile(String token) async {
    try {
      final response = await dio.get(
        ApiEndpoints.userProfile,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return Right(UserApiModel.fromJson(response.data));
    } catch (e) {
      return Left(ApiFailure(message: "Failed to fetch user profile: ${e.toString()}"));
    }
  }

  /// Logout API Call
  Future<Either<Failure, void>> logout(String token) async {
    try {
      await dio.get(
        ApiEndpoints.userLogout,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: "Logout failed: ${e.toString()}"));
    }
  }

  /// Upload Image API Call
  Future<Either<Failure, String>> uploadImage(File image) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path),
      });

      final response = await dio.post(
        ApiEndpoints.uploadUserImage,
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      return Right(response.data['imageUrl']); // Image URL returned from API
    } catch (e) {
      return Left(ApiFailure(message: "Image upload failed: ${e.toString()}"));
    }
  }
}
