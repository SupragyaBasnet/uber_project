import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/bloc/payment_bloc.dart';

import 'package:uber_mobile_app_project/data/repositories/payment_repository.dart';

class MockPaymentRepository extends Mock implements PaymentRepository {}

void main() {
  late MockPaymentRepository mockPaymentRepository;
  late PaymentBloc paymentBloc;

  setUp(() {
    mockPaymentRepository = MockPaymentRepository();
    paymentBloc = PaymentBloc(mockPaymentRepository);
  });

  blocTest<PaymentBloc, PaymentState>(
    '✅ emits [PaymentProcessing, PaymentSuccess] when payment is processed',
    build: () {
      when(() => mockPaymentRepository.processPayment(any(), any(), any())).thenAnswer((_) async => true);
      return paymentBloc;
    },
    act: (bloc) => bloc.add(ProcessPaymentEvent('1', 50.0, 'Card')),
    expect: () => [PaymentProcessing(), PaymentSuccess()],
  );
}
