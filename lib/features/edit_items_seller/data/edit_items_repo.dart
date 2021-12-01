import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/models.dart';

class EditItemsRepo{
  Future<List<SellerItems>> fetchItems()async{
    final List<SellerItems> list=[];
    final data=await FirebaseFirestore.instance.collection("Items").where("seller",isEqualTo: MasterModel.auth.currentUser.email).get();
    if(data!=null){
      for(int i=0;i<data.size;i++){
        final SellerItems item=SellerItems(image1: data.docs[i].data()['image1']as String,image2: data.docs[i].data()['image2']as String,image3: data.docs[i].data()['image3']as String,image4: data.docs[i].data()['image4']as String,productName: data.docs[i].data()['productName']as String,productPrice: data.docs[i].data()['productPrice']as double,productDescription: data.docs[i].data()['productDescription']as String,isAvailable: data.docs[i].data()['isAvailable']as bool,seller: data.docs[i].data()['seller']as String,id:data.docs[i].id);
        list.add(item);
      }
    }
    return list;
  }
}
