import 'package:eshop/models/master_model.dart';
import 'package:eshop/utils/utils.dart';

class MobileNumber{
  Future<String> retrieveMobile()async{
    final data=await FirebaseFirestore.instance.collection("users").doc("alok.kvbrp@gmail.com").get();
    print(data.data()['mobile']);
    return data.data()['mobile'] as String;
  }
}
//todo path dekho