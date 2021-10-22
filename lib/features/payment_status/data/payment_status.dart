import 'package:eshop/models/master_model.dart';
import 'package:eshop/utils/utils.dart';

class PaymentStatusRepo{
  final String doNotUse="";
  static Future<bool> getStatus()async{
    final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
    final Timestamp validity=data.data()['validity'] as Timestamp;
    final DateTime myDateTime = validity.toDate();
    final bool status=myDateTime.isAfter(DateTime.now());
    return status;
  }
  static Future<List> getOffer()async{
    final data=await FirebaseFirestore.instance.collection("admin").doc("offer").get();
    final List list=[];
    if(data.exists){
      final imageAddress=data.data()['image']as String;
      final code=data.data()['coupon']as String;
      final validity=data.data()['validity']as int;
      list.add(imageAddress);
      list.add(code);
      list.add(validity);
    }
    return list;
  }
}
