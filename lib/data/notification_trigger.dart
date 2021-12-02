import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class NotificationTrigger{
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  Future<void> trigger({String recipient,String title,String body,String orderID})async{
    try{
       final data=await FirebaseFirestore.instance.collection("users").doc(recipient).get();
       final key=data.data()['notificationKey'];
       final Map <String , dynamic> payLoad={"to": key,"notification": {"body": body,"title": title},"data":{"orderId": orderID}};
       final Map<String,String> header = { "Content-Type": "application/json", "Authorization": "key=AAAAYkxktgY:APA91bH4N6yWRKNzhgU-_t7Cauz9Oe1HxQf9fjT3QODStDuKWuuHJ0rlu_UORZSHf7FCya4Ts6iE02Xkpy3BLc_NCqyz68DIJRrD7_Le7BSmFCi7RoQ9961e4KctXYfGeojNa9XATAnf"};
       await http.post(url, body: jsonEncode(payLoad),headers:header);
       final Map<String, dynamic> temp =
       data.data()['notification'] as Map<String, dynamic>;
       temp[DateTime.now().microsecondsSinceEpoch.toString()]=orderID;
       await FirebaseFirestore.instance.collection("users").doc(recipient).update({
         "isNotificationSeen":false,
         "notification":temp
       });
    }
    catch(e){
      ErrorHandle.showError("Something wrong");
    }
  }
}
