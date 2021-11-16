import 'package:eshop/models/master_model.dart';
import 'package:eshop/utils/utils.dart';

class MobileNumber{
  Future<String> retrieveMobile()async{
    final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
    return data.data()['mobile'] as String;
  }
}
