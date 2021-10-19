import 'package:eshop/utils/utils.dart';

class PaymentStatusRepo{
  final String doNotUse="";
  static Future<bool> getStatus()async{
    final data=await FirebaseFirestore.instance.collection("users").doc("alok.kvbrp@gmail.com").get();
    final Timestamp validity=data.data()['validity'] as Timestamp;
    final DateTime myDateTime = validity.toDate();
    print(myDateTime);
    if(myDateTime.isAfter(DateTime.now())){
      return true;
    }
    else{
      return false;
    }
  }
}
