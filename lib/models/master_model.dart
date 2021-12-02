import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasterModel{
  final data="do nothing";
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static FirebaseAuth auth=FirebaseAuth.instance;
  static SharedPreferences sharedPreferences;
  static Future<void> signOut()async{
    await auth.signOut().then((value)async{
      await googleSignIn.disconnect();
    });
  }
}
