import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:uber_mobile_app_project/core/error/failure.dart';
import 'package:uber_mobile_app_project/core/network/api_service.dart';
import '../../data/model/user_api_model.dart';
import '../repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;

  UserRepositoryImpl({required this.apiService, required Box userBox});

  @override
  Future<Either<Failure, UserApiModel>> login(String phonenumber,
      String password) async {
    try {
      final response = await apiService.userLogin(phonenumber, password);
      return Right(UserApiModel.fromJson(response));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserApiModel>> signup({
    required String firstname,
    required String lastname,
    required String phonenumber,
    required String email,
    required String password,
    File? image,
  }) async {
    try {
      String? profileImageUrl;
      if (image != null) {
        final uploadResult = await uploadImage(image);
        uploadResult.fold(
              (failure) => throw ApiFailure(message: failure.message),
              (imageUrl) => profileImageUrl = imageUrl,
        );
      }

      final response = await apiService.userSignup(
        firstname: firstname,
        lastname: lastname,
        phonenumber: phonenumber,
        email: email,
        password: password,
        profileImage: profileImageUrl,
      );

      return Right(UserApiModel.fromJson(response));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File image) async {
    try {
      final response = await apiService.uploadUserImage(image);
      return Right(response);
    } catch (e) {
      return Left(ApiFailure(message: "Image upload failed: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserApiModel>> getUserProfile() {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }

//   @override
//   Future<Either<Failure, UserApiModel>> getUserProfile() async {
//     try {
//       final response = await apiService.getUserProfile();
//       return Right(UserApiModel.fromJson(response));
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }
}
