import 'package:eshop/models/master_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: const Text("User Detail"),
                onPressed: (){
                  try{
                    print(MasterModel.auth.currentUser.email);
                  }
                  catch(e){
                    print(e);
                  }
                },
              ),
              ElevatedButton(
                child: const Text("Login"),
                onPressed: (){
                  Future<UserCredential> signInWithGoogle() async {
                    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication googleAuth = await googleUser?.authentication;
                    final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth?.accessToken,
                      idToken: googleAuth?.idToken,
                    );
                    print("Success");
                    return FirebaseAuth.instance.signInWithCredential(credential);
                  }
                  signInWithGoogle();
                },
              ),
              ElevatedButton(
                child: const Text("Logout"),
                onPressed: ()async{
                  await MasterModel.auth.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
