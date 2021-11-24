import 'package:eshop/features/fetch_items_shop/domain/seller_item_class.dart';
import 'package:eshop/utils/utils.dart';

class FetchShopItems {
  Future<List<SellerItemsClass>> getItemsShop(String sellerEmail) async {
    final List<SellerItemsClass> list = [];
    final data = await FirebaseFirestore.instance
        .collection("Items")
        .where("seller", isEqualTo: sellerEmail)
        .get();
    if (data != null) {
      for (int i = 0; i < data.docs.length; i++) {
        final SellerItemsClass obj = SellerItemsClass(
          image1: data.docs[i].data()['image1'] as String,
          image2: data.docs[i].data()['image2'] as String,
          image3: data.docs[i].data()['image3'] as String,
          image4: data.docs[i].data()['image4'] as String,
          productName: data.docs[i].data()['productName'] as String,
          productDescription:
              data.docs[i].data()['productDescription'] as String,
          productPrice: data.docs[i].data()['productPrice'] as double,
          seller: data.docs[i].data()['seller'] as String,
          isAvailable: data.docs[i].data()['isAvailable'] as bool,
          productID: data.docs[i].id,
        );
        list.add(obj);
      }
    }
    return list;
  }
}
