import 'package:eshop/features/payment_status/data/payment_status.dart';
import 'package:flutter/material.dart';

class SellerHome extends StatefulWidget {

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {

  @override
  void initState() {
    PaymentStatusRepo.getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("Seller page"),
      ),
    );
  }
}
