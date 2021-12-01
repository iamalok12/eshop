import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/models.dart';

class FetchOrderSellerRepo{
  Future<List<OrderModel>> getOrders()async{
    final List<OrderModel> list =[];
    final data=await FirebaseFirestore.instance.collection("orders").where("seller",isEqualTo: MasterModel.auth.currentUser.email).get();
    if(data.size>0){
      for(int i=0;i<data.size;i++){
        final obj=OrderModel.fromJson(data.docs[i].data());
        list.add(obj);
      }
    }
    return list;
  }
}
