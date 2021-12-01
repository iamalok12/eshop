import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/fetch_cart/domain/fetch_cart_class.dart';


class FetchCartRepo {
  Future<List<FetchCartClass>> getCart(String productID) async {
    final List<FetchCartClass> list = [];
    final data = await FirebaseFirestore.instance
        .collection("Items")
        .doc(productID)
        .get();
    if (data.exists) {
      final FetchCartClass obj1 = FetchCartClass(
          image1: data.data()['image1'] as String,
          image2: data.data()['image2'] as String,
          image3: data.data()['image3'] as String,
          image4: data.data()['image4'] as String,
          productName: data.data()['productName'] as String,
          productPrice: data.data()['productPrice'] as double,
          productDescription: data.data()['productDescription'] as String,
          isAvailable: data.data()['isAvailable'] as bool,
          seller: data.data()['seller'] as String,
          productID: data.id,);
      list.add(obj1);
    } else if (!data.exists) {
      final FetchCartClass obj2 =
          FetchCartClass(image1: "product do not exist",productID: productID);
      list.add(obj2);
    }
    return list;
  }
}
