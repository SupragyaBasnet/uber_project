import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/payment_provider.dart';
 // ✅ Fixed import path

class PaymentScreen extends StatefulWidget {
  final String rideId;
  final double amount;

  const PaymentScreen({Key? key, required this.rideId, required this.amount}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = 'Card';

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Amount to Pay: \$${widget.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              items: ['Card', 'PayPal', 'Cash']
                  .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            paymentProvider.isProcessing
                ? const CircularProgressIndicator() // Show loader while processing payment
                : ElevatedButton(
              onPressed: () async {
                bool success = await paymentProvider.processPayment(
                  rideId: widget.rideId,
                  amount: widget.amount,
                  method: selectedPaymentMethod,
                );
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment successful!')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(paymentProvider.errorMessage ?? 'Payment failed. Try again.')),
                  );
                }
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
