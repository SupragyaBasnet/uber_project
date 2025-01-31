import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:uber_mobile_app_project/core/error/failure.dart';
import '../../data/model/captain_api_model.dart';
import '../../domain/repository/captain_repository.dart';
import 'captain_signup_event.dart';
import 'captain_signup_state.dart';

class CaptainSignupBloc extends Bloc<CaptainSignupEvent, CaptainSignupState> {
  final CaptainRepository captainRepository;

  CaptainSignupBloc({required this.captainRepository}) : super(CaptainSignupInitial()) {
    on<CaptainSignupRequestEvent>(_onSignup);
  }

  Future<void> _onSignup(
      CaptainSignupRequestEvent event,
      Emitter<CaptainSignupState> emit,
      ) async {
    emit(CaptainSignupLoading());

    try {
      // ✅ Ensure vehicleCapacity is an integer
      final int vehicleCapacityInt = int.tryParse(event.vehicleCapacity) ?? 0;
      if (vehicleCapacityInt <= 0) {
        emit(CaptainSignupFailure("Vehicle capacity must be a valid number"));
        return;
      }

      // ✅ Upload image if provided
      String? profileImageUrl;
      if (event.image != null) {
        final uploadResult = await captainRepository.uploadImage(event.image!);
        uploadResult.fold(
              (failure) => throw ApiFailure(message: failure.message),
              (imageUrl) => profileImageUrl = imageUrl,
        );
      }

      // ✅ Debugging print statements (Check values at runtime)
      print("First Name: ${event.firstname}");
      print("Last Name: ${event.lastname}");
      print("Phone Number: ${event.phonenumber}");
      print("Email: ${event.email}");
      print("Password: ${event.password}");
      print("Vehicle Color: ${event.vehicleColor}");
      print("Vehicle Plate: ${event.vehiclePlate}");
      print("Vehicle Capacity: ${event.vehicleCapacity}");
      print("Vehicle Type: ${event.vehicleType}");
      print("Profile Image URL: $profileImageUrl");

      // ✅ Pass correctly formatted parameters
      final response = await captainRepository.signup(
        firstname: event.firstname,
        lastname: event.lastname,
        phonenumber: event.phonenumber,
        email: event.email,
        password: event.password,
        vehicleColor: event.vehicleColor,
        vehiclePlate: event.vehiclePlate,
        vehicleCapacity: vehicleCapacityInt, // ✅ Fixed type issue
        vehicleType: event.vehicleType,
        image: profileImageUrl != null ? File(profileImageUrl!) : null, // ✅ Safe conversion
      );

      response.fold(
            (failure) => emit(CaptainSignupFailure(failure.message)),
            (_) => emit(CaptainSignupSuccess()),
      );
    } catch (e) {
      emit(CaptainSignupFailure("Unexpected error occurred: ${e.toString()}"));
    }
  }
}
