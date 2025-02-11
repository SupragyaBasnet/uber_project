import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/model/user_api_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserApiModel>> login(String phonenumber, String password);

  Future<Either<Failure, UserApiModel>> signup({
    required String firstname,
    required String lastname,
    required String phonenumber,
    required String email,
    required String password,
    File? image,
  });

  Future<Either<Failure, UserApiModel>> getUserProfile();

  Future<Either<Failure, String>> uploadImage(File image);
}
