
import 'package:eshop/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MasterModel{
  final data="do nothing";
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static FirebaseAuth auth=FirebaseAuth.instance;
  static Future<void> signOut()async{
    await auth.signOut();
    await googleSignIn.disconnect();
  }
}
