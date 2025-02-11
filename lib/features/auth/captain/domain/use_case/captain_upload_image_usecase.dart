import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

import '../../data/model/captain_api_model.dart';


abstract class CaptainRepository {
  /// Captain Login
  Future<Either<Failure, CaptainApiModel>> login(String phonenumber, String password);

  /// Captain Signup
  Future<Either<Failure, CaptainApiModel>> signup(CaptainApiModel captain);

  /// Get Captain Profile
  Future<Either<Failure, CaptainApiModel>> getCaptainProfile();

  /// Logout
  Future<Either<Failure, void>> logout();

  /// Upload Image
  Future<Either<Failure, String>> uploadImage(File image);
}
