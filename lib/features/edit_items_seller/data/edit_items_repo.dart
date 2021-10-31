import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/models/seller_items.dart';

class EditItemsRepo{
  Future<List<SellerItems>> fetchItems()async{
    List<SellerItems> list=[];
    final data=await FirebaseFirestore.instance.collection("Items").where("seller",isEqualTo: MasterModel.auth.currentUser.email).get();
    if(data!=null){
      for(int i=0;i<data.size;i++){
        SellerItems items=SellerItems(image1: data.docs[i].data()['image1']as String);
      }
    }
  }
}
