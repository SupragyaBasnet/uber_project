import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:uber_mobile_app_project/core/error/failure.dart';
import 'package:uber_mobile_app_project/core/network/api_service.dart';
import '../../data/model/captain_api_model.dart';
import '../repository/captain_repository.dart';

class CaptainRepositoryImpl implements CaptainRepository {
  final ApiService apiService;

  CaptainRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, CaptainApiModel>> login({required String phonenumber, required String password}) async {
    try {
      final response = await apiService.captainLogin(phonenumber, password);
      return Right(CaptainApiModel.fromJson(response));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CaptainApiModel>> signup({
    required String firstname,
    required String lastname,
    required String phonenumber,
    required String email,
    required String password,
    required String vehicleColor,
    required String vehiclePlate,
    required int vehicleCapacity, // Ensuring integer type
    required String vehicleType,
    File? image,
  }) async {
    try {
      String? profileImageUrl;

      // ✅ Upload Image and Get URL
      if (image != null) {
        final uploadResult = await uploadImage(image);
        uploadResult.fold(
              (failure) => throw ApiFailure(message: failure.message),
              (imageUrl) => profileImageUrl = imageUrl, // ✅ Correctly storing URL
        );
      }

      // ✅ Correctly pass the image URL (not as File)
      final response = await apiService.captainSignup(
        firstname: firstname,
        lastname: lastname,
        phonenumber: phonenumber,
        email: email,
        password: password,
        color: vehicleColor,
        plate: vehiclePlate,
        capacity: vehicleCapacity,
        vehicleType: vehicleType,
        profileImage: profileImageUrl, // ✅ Now correctly passing the String URL
      );

      return Right(CaptainApiModel.fromJson(response));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File image) async {
    try {
      final response = await apiService.uploadCaptainImage(image);
      return Right(response);
    } catch (e) {
      return Left(ApiFailure(message: "Image upload failed: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, CaptainApiModel>> getCaptainProfile() {
    // TODO: Implement getCaptainProfile
    throw UnimplementedError();
  }
}
