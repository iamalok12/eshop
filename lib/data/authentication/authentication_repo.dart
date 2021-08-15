import 'package:eshop/utils/utils.dart';

class AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<String> type() async {
    final data = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser.phoneNumber)
        .get();
    if(!data.exists){
      return null;
    }
    else{
      final String type = data.data()['type'].toString();
      return type;
    }
  }
}
