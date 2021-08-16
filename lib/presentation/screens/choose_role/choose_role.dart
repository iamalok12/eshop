import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:eshop/utils/utils.dart';
import 'package:lottie/lottie.dart';


class ChooseRole extends StatefulWidget {


  @override
  _ChooseRoleState createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {

  String roleSelected="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/choose_role_bg.jpeg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 26, left: 30, right: 20, bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      text: "What are",
                      style: kViewStyle.copyWith(color: kWhiteColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: " You !",
                          style: kViewStyle.copyWith(color: kBlackColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 30, right: 20, bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      text: "Seller",
                      style: kViewStyle.copyWith(color: kWhiteColor),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  roleSelected="seller";
                });
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    border: Border.all(color:roleSelected=="seller"?kChooseRoleButtonColor:Colors.transparent,width: 5),
                    shape: BoxShape.circle,
                  ),
                  height: 185.w,
                  width: 185.w,
                  child: Lottie.asset('assets/images/seller_bt.json',height: 80,width: 80),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 26, left: 30, right: 20, bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      text: "Customer",
                      style: kViewStyle.copyWith(color: kWhiteColor),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  roleSelected="customer";
                });
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    border: Border.all(color:roleSelected=="customer"?kChooseRoleButtonColor:Colors.transparent,width: 5),
                    shape: BoxShape.circle,
                  ),
                  height: 185.w,
                  width: 185.w,
                  child: Lottie.asset('assets/images/customer_btt.json',height: 80,width: 80),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
