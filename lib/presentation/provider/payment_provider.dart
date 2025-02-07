// lib/presentation/providers/payment_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/constants.dart';

class PaymentProvider with ChangeNotifier {
  bool _isProcessing = false;
  String? _errorMessage;

  bool get isProcessing => _isProcessing;
  String? get errorMessage => _errorMessage;

  /// Process a payment request
  Future<bool> processPayment({
    required String rideId,
    required double amount,
    required String method,
  }) async {
    _isProcessing = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(ApiConstants.paymentEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "rideId": rideId,
          "amount": amount,
          "paymentMethod": method,
        }),
      );

      if (response.statusCode == 201) {
        _isProcessing = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = jsonDecode(response.body)['message'] ?? "Payment failed.";
        _isProcessing = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "Payment error: $e";
      _isProcessing = false;
      notifyListeners();
      return false;
    }
  }
}
