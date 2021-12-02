import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/models.dart';

class MobileNumber{
  Future<String> retrieveMobile()async{
    final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
    return data.data()['mobile'] as String;
  }
}
