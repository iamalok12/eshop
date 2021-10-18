import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHandler{
  final _razorpay = Razorpay();
  Future<void> checkOut(int amount)async{
    final options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': 2000,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
}
