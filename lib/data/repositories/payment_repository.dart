import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';

class PaymentRepository {
  /// ✅ **New Method: Process Payment**
  Future<bool> processPayment(String rideId, double amount, String method) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConstants.paymentEndpoint}/process"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "rideId": rideId,
          "amount": amount,
          "paymentMethod": method,
        }),
      );

      if (response.statusCode == 200) {
        return true; // ✅ Payment successful
      } else {
        throw Exception('Failed to process payment: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error processing payment: $e');
    }
  }
}
