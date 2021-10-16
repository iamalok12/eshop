import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/authentication/login_screen.dart';
import 'package:eshop/screens/customer/customer_home/customer_home.dart';
import 'package:eshop/screens/seller/seller_home/seller_home.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> goToScreen()async {
    try{
      final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
      if(data.exists){
        print("data found");
        final String type=data.data()['type'] as String;
        if(type=='customer'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerHome(),),);
        }
        else if(type=='seller'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerHome(),),);
        }
      }
      else{
        print("data not found");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(),),);
      }
    }
    catch(e){
      print("error");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 60.0,
              fontFamily: 'Horizon',
            ),
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 10),
              totalRepeatCount: 1,
              onFinished: goToScreen,
              animatedTexts: [
                RotateAnimatedText(
                  'E-Shop',
                  textStyle: const TextStyle(color: Colors.white,letterSpacing: 3),
                  rotateOut: false,
                  duration: const Duration(milliseconds: 1000)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
