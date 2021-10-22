import 'package:eshop/screens/authentication/customer_register.dart';
import 'package:eshop/screens/authentication/seller_register1.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ChooseRole extends StatefulWidget {
  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  String role = "customer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Text(
                "Choose Role",
                style: TextStyle(fontSize: 30.sp, fontFamily: "Orbitron"),
              ),
              SizedBox(
                height: 80.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        role = "customer";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: role == 'customer' ? 3 : 1,
                            color: role == 'customer'
                                ? Colors.black
                                : Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 160.w,
                      width: 130.w,
                      child: Column(
                        children: [
                          Lottie.asset("assets/images/choose_customer.json"),
                          SizedBox(
                            height: 5.h,
                          ),
                          const Text(
                            "Customer",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        role = "seller";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: role == 'seller' ? 3 : 1,
                            color: role == 'seller'
                                ? Colors.black
                                : Colors.black26,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 160.w,
                      width: 130.w,
                      child: Column(
                        children: [
                          Lottie.asset("assets/images/choose_seller.json"),
                          SizedBox(
                            height: 5.h,
                          ),
                          const Text(
                            "Seller",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 180.h,
              ),
              PrimaryButton(
                label: "Next",
                callback: () {
                  if (role == "customer") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerRegister(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellerRegister1(),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
