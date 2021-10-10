import 'package:eshop/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    void goToScreen(){
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(),),);
      });
    }
    goToScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("Splash Screen",style: TextStyle(fontSize: 40),),
      ),
    );
  }
}
