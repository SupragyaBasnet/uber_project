import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uber_mobile_app_project/data/repositories/payment_repository.dart';

// Mock Repository
class MockPaymentRepository extends Mock implements PaymentRepository {}

void main() {
  late MockPaymentRepository mockPaymentRepository;

  setUp(() {
    mockPaymentRepository = MockPaymentRepository();
  });

  test('3️⃣ Should process a successful payment', () async {
    when(() => mockPaymentRepository.processPayment(any(), any(), any()))
        .thenAnswer((_) async => true);

    final result = await mockPaymentRepository.processPayment('1', 15.0, 'Card');

    expect(result, true);
    verify(() => mockPaymentRepository.processPayment(any(), any(), any())).called(1);
  });

  test('4️⃣ Should fail when payment processing encounters an error', () async {
    when(() => mockPaymentRepository.processPayment(any(), any(), any()))
        .thenThrow(Exception("Payment Error"));

    expect(() => mockPaymentRepository.processPayment('1', 15.0, 'Card'), throwsException);
  });
}
