import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/seller_profile/domain/seller_profile_class.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/widgets/widgets.dart';


class SellerProfileRepo{
  Future<List<SellerProfileClass>> getData()async{
    final List<SellerProfileClass> list=[];
    final data= await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
    if(data.exists){
      final SellerProfileClass obj=SellerProfileClass(
        sellerName: data.data()['name'] as String,
        shopName: data.data()['shopName'] as String,

        image1: data.data()['image1'] as String,
        image2: data.data()['image2'] as String,
        image3: data.data()['image3'] as String,
        image4: data.data()['image4'] as String,

        area: data.data()['area'] as String,
        locality: data.data()['locality'] as String,
        city: data.data()['city'] as String,
        picCode: data.data()['pinCode'] as String,

        validity: data.data()['validity'] as Timestamp,
      );
      list.add(obj);
    }
    else{
      ErrorHandle.showError("Something wrong");
    }
    return list;
  }
}
