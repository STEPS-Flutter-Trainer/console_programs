import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _openCheckout() {
    var options = {
      'key': 'YOUR_RAZORPAY_KEY_ID', // Replace with your Razorpay Key ID
      'amount': 100, // Amount in paise (i.e., 100 paise = 1 INR)
      'name': 'Test Payment',
      'description': 'Payment for testing',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@example.com',
      },
      'theme': {
        'color': '#F37254',
      },
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment here
    print("Payment Successful: ${response.paymentId}");
    // You can show a success message or navigate to another page
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle failed payment here
    print("Payment Failed: ${response.code} - ${response.message}");
    // You can show an error message to the user
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment here
    print("External Wallet: ${response.walletName}");
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Razorpay Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: _openCheckout,
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: PaymentPage()));
}
