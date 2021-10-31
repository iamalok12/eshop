import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/authentication/login_screen.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LogoutSeller extends StatefulWidget {
  @override
  State<LogoutSeller> createState() => _LogoutSellerState();
}
class _LogoutSellerState extends State<LogoutSeller> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              SizedBox(height: 300.w,width: 300.w,child: Lottie.asset("assets/images/logout.json",fit: BoxFit.fill),),
              SizedBox(height: 10.h,),
              Text("Logout... \n Are you sure?",style: TextStyle(fontSize: 25.sp),textAlign: TextAlign.center,),
              SizedBox(height: 60.h,),
              PrimaryButton(callback: ()async{
                MasterModel.signOut().then((value){
                  Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),),);
                }).onError((error, stackTrace){
                  ErrorHandle.showError("Something wrong");
                });
              },label: "Logout",)
            ],
          ),
        ),
      ),
    );
  }
}
