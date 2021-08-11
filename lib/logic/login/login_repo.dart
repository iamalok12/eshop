import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo{
  String _verificationCode;
  final String mobile;
  LoginRepo(this.mobile);
  String get getVerificationCode => _verificationCode;
  Future<void> login(String mobile)async{
      await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: "+91$mobile",
    verificationCompleted: (PhoneAuthCredential credential) async {
      print(credential);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        if (value.user != null) {
          // print("user logged in direct");
        }
      });
    },
    verificationFailed: (FirebaseAuthException e) {
      // print(e.message);
    },
    codeSent: (String verificationID, int resendToken) {
      _verificationCode=verificationID;
    },
    codeAutoRetrievalTimeout: (String verificationID) {},
  );
  }
}