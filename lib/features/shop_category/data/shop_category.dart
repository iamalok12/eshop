
import 'package:eshop/utils/utils.dart';

class ShopCategory{
  Future<List<String>> getShopCategory()async{
    final data = await FirebaseFirestore.instance.collection("admin").doc("categories").get();
    final List<String> shopCategories= List.from(data.data()['shopCategories'] as Iterable<dynamic>);
    return shopCategories;
  }
}