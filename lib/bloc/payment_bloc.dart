import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/payment_repository.dart';

/// **Events**
abstract class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProcessPaymentEvent extends PaymentEvent {
  final String rideId;
  final double amount;
  final String method;
  ProcessPaymentEvent(this.rideId, this.amount, this.method);
}

/// **States**
abstract class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentSuccess extends PaymentState {}

class PaymentError extends PaymentState {
  final String message;
  PaymentError({required this.message});
}

/// **BLoC Implementation**
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc(this.paymentRepository) : super(PaymentInitial()) {
    on<ProcessPaymentEvent>((event, emit) async {
      emit(PaymentProcessing());
      try {
        await paymentRepository.processPayment(event.rideId, event.amount, event.method);
        emit(PaymentSuccess());
      } catch (e) {
        emit(PaymentError(message: e.toString()));
      }
    });
  }
}
