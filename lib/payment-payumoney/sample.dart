import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final String merchantKey = 'YOUR_MERCHANT_KEY'; // Replace with your Merchant Key
  final String salt = 'YOUR_SALT'; // Replace with your Salt
  final String paymentUrl = 'https://test.payu.in/_payment'; // Use test URL for sandbox

  Future<void> _initiatePayment() async {
    // Replace with actual transaction details
    final paymentData = {
      'key': merchantKey,
      'txnid': 'txn12345',
      'amount': '10.00',
      'productinfo': 'Test Product',
      'firstname': 'John',
      'email': 'john.doe@example.com',
      'phone': '1234567890',
      'surl': 'https://yourcallbackurl.com/success', // Success URL
      'furl': 'https://yourcallbackurl.com/failure', // Failure URL
    };

    // Generate hash for the payment
    String hash = _generateHash(paymentData);
    paymentData['hash'] = hash;

    // Send payment request
    final response = await http.post(
      Uri.parse(paymentUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(paymentData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Handle successful payment initiation
      print('Payment initiated: $responseData');
    } else {
      // Handle error
      print('Payment initiation failed: ${response.body}');
    }
  }

  String _generateHash(Map<String, String> data) {
    // Generate a hash using your Merchant Salt and the payment details
    // You will need to implement hash generation logic according to PayUMoney's guidelines
    return ''; // Return the generated hash
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PayUMoney Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: _initiatePayment,
          child: Text('Make Payment'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: PaymentPage()));
}
