import 'package:equatable/equatable.dart';
import '../../domain/entity/captain_entity.dart';

abstract class CaptainLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CaptainLoginInitial extends CaptainLoginState {}

class CaptainLoginLoading extends CaptainLoginState {}

class CaptainLoginSuccess extends CaptainLoginState { // ✅ Accept CaptainEntity
  final CaptainEntity captain;

  CaptainLoginSuccess(this.captain);

  @override
  List<Object?> get props => [captain];
}

class CaptainLoginFailure extends CaptainLoginState {
  final String error;

  CaptainLoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
