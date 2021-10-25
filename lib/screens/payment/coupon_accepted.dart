import 'package:eshop/screens/seller/seller_home/seller_root.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CouponAccepted extends StatefulWidget {
  @override
  _CouponAcceptedState createState() => _CouponAcceptedState();
}

class _CouponAcceptedState extends State<CouponAccepted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100.h,),
              Text("Coupon accepted",style:kPageHeading),
              SizedBox(height: 300.w,width: 300.w,child: Lottie.asset("assets/images/coupon.json"),),
              SizedBox(height: 100.h,),
              PrimaryButton(label: "Go Home",callback: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerRoot(),),);
              },)
            ],
          ),
        ),
      ),
    );
  }
}
