import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentBox extends StatelessWidget {
  final int amount;
  final VoidCallback callback;
  final String month;

  const PaymentBox({Key key, this.amount, this.callback, this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 40.h,
        width: 280.w,
        decoration: BoxDecoration(
          color: const Color(0xffE63E6D),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text("₹ $amount / $month",style: TextStyle(fontSize: 18.sp,color: Colors.white),),),
      ),
    );
  }
}
