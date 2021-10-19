import 'package:eshop/key/razor_pay_key.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHandler{
  final _razorpay = Razorpay();
  Future<void> checkOut(int amount,String mobile,String email)async{
    final options = {
      'key': razorPayKey,
      'amount': amount*100,
      'name': 'E Shop',
      'description': 'Membership fee',
      'prefill': {'contact': mobile, 'email': email},
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
