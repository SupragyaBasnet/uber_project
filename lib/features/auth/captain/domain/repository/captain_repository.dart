import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/model/captain_api_model.dart';

abstract class CaptainRepository {
  Future<Either<Failure, CaptainApiModel>> login({required String phonenumber, required String password});

  Future<Either<Failure, CaptainApiModel>> signup({
    required String firstname,
    required String lastname,
    required String phonenumber,
    required String email,
    required String password,
    required String vehicleColor,
    required String vehiclePlate,
    required int vehicleCapacity, // Changed from String to int
    required String vehicleType,
    File? image,
  });

  Future<Either<Failure, CaptainApiModel>> getCaptainProfile();

  Future<Either<Failure, String>> uploadImage(File image);
}
