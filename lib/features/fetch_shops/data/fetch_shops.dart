import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/fetch_shops/domain/fetch_shop_class.dart';

class FetchShops {
  Future<List<FetchShopsClass>> getShops(String city) async {
    final List<FetchShopsClass> list = [];
    final data = await FirebaseFirestore.instance
        .collection("users")
        .where("city", isEqualTo: city)
        .get();
    if (data != null) {
      for (int i = 0; i < data.size; i++) {
        final FetchShopsClass shop = FetchShopsClass(
          image1: data.docs[i].data()['image1'] as String,
          image2: data.docs[i].data()['image2'] as String,
          image3: data.docs[i].data()['image3'] as String,
          image4: data.docs[i].data()['image4'] as String,
          name: data.docs[i].data()['name'] as String,
          shopName: data.docs[i].data()['shopName'] as String,
          pinCode: data.docs[i].data()['pinCode'] as String,
          area: data.docs[i].data()['area'] as String,
          locality: data.docs[i].data()['locality'] as String,
          category: data.docs[i].data()['category'] as String,
          city: data.docs[i].data()['city'] as String,
          mobile: data.docs[i].data()['mobile'] as String,
          shopMail: data.docs[i].id,
        );
        if(shop.image1.isNotEmpty){
          list.add(shop);
        }
      }
    }
    return list;
  }
}
