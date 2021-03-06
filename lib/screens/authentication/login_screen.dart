import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
              ),
              Text(
                "E-Shop",
                style: kIntroStyle.copyWith(color: kBlack),
              ),
              SizedBox(
                height: 160.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Future<void> fetchRoleAndNavigate(String email)async{
                    try{
                      final data=await FirebaseFirestore.instance.collection("users").doc(email).get();
                      if(data.exists){
                        final String type=data.data()['type']as String;
                        if(type=='customer'){
                          await Future.delayed(const Duration(milliseconds: 100));
                          if (!mounted) return;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerRoot(),),);
                        }
                        else{
                          await Future.delayed(const Duration(milliseconds: 100));
                          if (!mounted) return;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerRoot(),),);
                        }
                      }
                      else{
                        await Future.delayed(const Duration(milliseconds: 100));
                        if (!mounted) return;
                        Navigator.of(context,rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>ChooseRole()), (Route<dynamic> route) => false);
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChooseRole(),),);
                      }
                    }
                    catch(e){
                      ErrorHandle.showError("Something wrong");
                    }
                  }
                  Future<void> signInWithGoogle() async {
                    try{
                      final GoogleSignInAccount googleUser =
                      await GoogleSignIn().signIn();
                      final GoogleSignInAuthentication googleAuth =
                      await googleUser?.authentication;
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth?.accessToken,
                        idToken: googleAuth?.idToken,
                      );
                      await FirebaseAuth.instance
                          .signInWithCredential(credential).then((value)async{
                        await fetchRoleAndNavigate(googleUser.email);
                      });
                    }
                    catch(e){
                      ErrorHandle.showError("Something wrong");
                    }
                  }
                  signInWithGoogle();
                },
                child: SizedBox(
                  width: 250.w,
                  height: 40.h,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        height: 38.w,
                        width: 38.w,
                        color: kWhite,
                        child: Image.asset(
                          "assets/icons/sign_in_icon.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        "Sign up with Google",
                        style: kGoogleButton,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
