import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<String> type() async {
    final data = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser.phoneNumber)
        .get();
    final String type = data.data()['type'].toString();
    return type;
  }
}
