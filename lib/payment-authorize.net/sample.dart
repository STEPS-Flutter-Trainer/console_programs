import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final String apiLoginId = 'YOUR_API_LOGIN_ID';
  final String transactionKey = 'YOUR_TRANSACTION_KEY';
  final String apiUrl = 'https://api.authorize.net/xml/v1/request.api'; // Use the appropriate API URL

  Future<void> _makePayment() async {
    final Map<String, dynamic> paymentData = {
      'createTransactionRequest': {
        'merchantAuthentication': {
          'name': apiLoginId,
          'transactionKey': transactionKey,
        },
        'transactionRequest': {
          'transactionType': 'authCaptureTransaction',
          'amount': '10.00', // Amount to charge
          'payment': {
            'creditCard': {
              'cardNumber': '4111111111111111', // Example card number
              'expirationDate': '12/25', // Expiration date
            },
          },
        },
      },
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(paymentData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Handle successful payment response
      print('Payment successful: $responseData');
    } else {
      // Handle error
      print('Payment failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authorize.Net Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: _makePayment,
          child: Text('Make Payment'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: PaymentPage()));
}
