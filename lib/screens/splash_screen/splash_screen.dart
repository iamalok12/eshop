import 'package:eshop/logics/login/data/user_repository.dart';
import 'package:eshop/logics/login/login/login_page.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  UserRepository _userRepository;

  // Future<void> goToScreen()async{
  //   await Future.delayed(const Duration(seconds: 2),(){
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(userRepository: _userRepository)));
  //   });
  // }
  @override
  void initState() {
    // goToScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 200.h,),
              Text("E-Shop",style: GoogleFonts.orbitron(fontSize: 50.sp),)
            ],
          ),
        )
      ),
    );
  }
}
