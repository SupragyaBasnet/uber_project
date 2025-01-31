import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import 'package:uber_mobile_app_project/core/error/failure.dart';
import 'package:uber_mobile_app_project/core/network/api_service.dart';

import '../../features/auth/user/data/model/user_api_model.dart';
import '../../features/auth/captain/data/model/captain_api_model.dart';

class AuthRepository {
  final ApiService apiService;
  final Box userBox;
  final Box captainBox;

  AuthRepository(this.apiService, this.userBox, this.captainBox);

  // ==============================
  // 🔐 USER AUTHENTICATION
  // ==============================

  /// **User Login**
  Future<Either<Failure, UserApiModel>> loginUser(String phonenumber, String password) async {
    try {
      final response = await apiService.userLogin(phonenumber, password);
      final user = UserApiModel.fromJson(response);

      // Save user data in Hive (Local Storage)
      await userBox.put('user', user.toJson());

      return Right(user);
    } catch (e) {
      return Left(ApiFailure(message: "User Login Failed: ${e.toString()}"));
    }
  }

  /// **User Signup**
  Future<Either<Failure, UserApiModel>> signupUser(UserApiModel user, File? image) async {
    try {
      // ✅ Upload Image if provided
      String? imageUrl;
      if (image != null) {
        final uploadResult = await uploadImage(image);
        uploadResult.fold(
              (failure) => throw ApiFailure(message: failure.message),
              (uploadedUrl) => imageUrl = uploadedUrl,
        );
      }

      final response = await apiService.userSignup(
        firstname: user.fullname.split(" ").first,
        lastname: user.fullname.split(" ").last,
        phonenumber: user.phonenumber,
        email: user.email,
        password: user.token, // Assuming password is stored as token (fix if needed)
        profileImage: imageUrl, // ✅ Correctly pass uploaded URL
      );

      final newUser = UserApiModel.fromJson(response);
      await userBox.put('user', newUser.toJson());

      return Right(newUser);
    } catch (e) {
      return Left(ApiFailure(message: "User Signup Failed: ${e.toString()}"));
    }
  }

  /// **Get User Profile**
  Future<Either<Failure, UserApiModel>> getUserProfile() async {
    try {
      final userJson = userBox.get('user');
      if (userJson == null) throw Exception("User not found in local storage");

      return Right(UserApiModel.fromJson(userJson));
    } catch (e) {
      return Left(ApiFailure(message: "Failed to fetch user profile: ${e.toString()}"));
    }
  }

  // ==============================
  // 🚖 CAPTAIN AUTHENTICATION
  // ==============================

  /// **Captain Login**
  Future<Either<Failure, CaptainApiModel>> loginCaptain(String phonenumber, String password) async {
    try {
      final response = await apiService.captainLogin(phonenumber, password);
      final captain = CaptainApiModel.fromJson(response);

      // Save captain data in Hive (Local Storage)
      await captainBox.put('captain', captain.toJson());

      return Right(captain);
    } catch (e) {
      return Left(ApiFailure(message: "Captain Login Failed: ${e.toString()}"));
    }
  }

  /// **Captain Signup**
  Future<Either<Failure, CaptainApiModel>> signupCaptain(CaptainApiModel captain, File? image) async {
    try {
      // ✅ Upload Image if provided
      String? imageUrl;
      if (image != null) {
        final uploadResult = await uploadImage(image);
        uploadResult.fold(
              (failure) => throw ApiFailure(message: failure.message),
              (uploadedUrl) => imageUrl = uploadedUrl,
        );
      }

      final response = await apiService.captainSignup(
        firstname: captain.firstname,
        lastname: captain.lastname,
        phonenumber: captain.phonenumber,
        email: captain.email,
        password: captain.password,
        color: captain.vehicle?.color ?? "",  // ✅ Handles null vehicle
        plate: captain.vehicle?.plate ?? "",
        capacity: captain.vehicle?.capacity ?? 0, // ✅ Ensuring integer type
        vehicleType: captain.vehicle?.vehicleType ?? "",
        profileImage: imageUrl,  // ✅ Now correctly passing a String
      );

      final newCaptain = CaptainApiModel.fromJson(response);
      await captainBox.put('captain', newCaptain.toJson());

      return Right(newCaptain);
    } catch (e) {
      return Left(ApiFailure(message: "Captain Signup Failed: ${e.toString()}"));
    }
  }

  /// **Get Captain Profile**
  Future<Either<Failure, CaptainApiModel>> getCaptainProfile() async {
    try {
      final captainJson = captainBox.get('captain');
      if (captainJson == null) throw Exception("Captain not found in local storage");

      return Right(CaptainApiModel.fromJson(captainJson));
    } catch (e) {
      return Left(ApiFailure(message: "Failed to fetch captain profile: ${e.toString()}"));
    }
  }

  // ==============================
  // 📤 IMAGE UPLOAD FUNCTION
  // ==============================

  /// **Upload Profile Image (For User & Captain)**
  Future<Either<Failure, String>> uploadImage(File image) async {
    try {
      final imageUrl = await apiService.uploadCaptainImage(image);
      return Right(imageUrl);
    } catch (e) {
      return Left(ApiFailure(message: "Image upload failed: ${e.toString()}"));
    }
  }

  // ==============================
  // 🚪 LOGOUT FUNCTION
  // ==============================

  /// **Logout User**
  Future<Either<Failure, void>> logoutUser() async {
    try {
      await userBox.clear();
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: "User logout failed: ${e.toString()}"));
    }
  }

  /// **Logout Captain**
  Future<Either<Failure, void>> logoutCaptain() async {
    try {
      await captainBox.clear();
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: "Captain logout failed: ${e.toString()}"));
    }
  }
}
