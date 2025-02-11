import 'package:equatable/equatable.dart';

abstract class CaptainLoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CaptainLoginRequested extends CaptainLoginEvent {
  final Map<String, dynamic> credentials;

  CaptainLoginRequested(this.credentials);

  @override
  List<Object?> get props => [credentials];
}
