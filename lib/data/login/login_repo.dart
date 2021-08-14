import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo{
  final FirebaseAuth auth = FirebaseAuth.instance;

    Future<void> sendOtp(
        String phoneNumber,
        PhoneVerificationFailed phoneVerificationFailed,
        PhoneVerificationCompleted phoneVerificationCompleted,
        PhoneCodeSent phoneCodeSent,
        PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
      print("otp fn triggered");
      print(phoneNumber);
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: phoneVerificationCompleted,
          codeSent:phoneCodeSent,
          verificationFailed: phoneVerificationFailed,
          codeAutoRetrievalTimeout: autoRetrievalTimeout
      );
    }
  Future<User> verifyAndLogin(
      String verificationId, String smsCode) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await auth.signInWithCredential(credential);
    return auth.currentUser;
  }
}