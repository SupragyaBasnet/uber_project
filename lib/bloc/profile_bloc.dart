import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model.dart';

/// **Events**
abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProfileEvent extends ProfileEvent {
  final String userId;
  FetchProfileEvent(this.userId);
}

class UpdateProfileEvent extends ProfileEvent {
  final String userId;
  final String name;
  UpdateProfileEvent(this.userId, this.name);
}

/// **States**
abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  ProfileLoaded({required this.user});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}

/// **🛠 Fixed BLoC Implementation**
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc(this.userRepository) : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final User? user = await userRepository.getUserProfile(event.userId);

        if (user == null) {
          emit(ProfileError(message: "User profile not found."));
        } else {
          emit(ProfileLoaded(user: user));
        }
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final User? updatedUser = await userRepository.updateUserProfile(event.userId, event.name);

        if (updatedUser == null) {
          emit(ProfileError(message: "Failed to update profile."));
        } else {
          emit(ProfileLoaded(user: updatedUser));
        }
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });
  }
}
