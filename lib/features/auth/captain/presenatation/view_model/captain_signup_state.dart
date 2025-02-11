import 'package:equatable/equatable.dart';
import '../../domain/entity/captain_entity.dart';

abstract class CaptainSignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CaptainSignupInitial extends CaptainSignupState {}

class CaptainSignupLoading extends CaptainSignupState {}

class CaptainSignupSuccess extends CaptainSignupState { // ✅ Accept CaptainEntity
  final CaptainEntity captain;

  CaptainSignupSuccess(this.captain);

  @override
  List<Object?> get props => [captain];
}

class CaptainSignupFailure extends CaptainSignupState {
  final String error;

  CaptainSignupFailure(this.error);

  @override
  List<Object?> get props => [error];
}
