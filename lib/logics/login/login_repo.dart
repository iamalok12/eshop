import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo{
  final FirebaseAuth auth = FirebaseAuth.instance;

    Future<void> sendOtp(
        String phoneNumber,
        Duration timeOut,
        PhoneVerificationFailed phoneVerificationFailed,
        PhoneVerificationCompleted phoneVerificationCompleted,
        PhoneCodeSent phoneCodeSent,
        PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
      auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: timeOut,
          verificationCompleted: phoneVerificationCompleted,
          verificationFailed: phoneVerificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: autoRetrievalTimeout);
    }
  Future<User> verifyAndLogin(
      String verificationId, String smsCode) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await auth.signInWithCredential(credential);
    return auth.currentUser;
  }
}