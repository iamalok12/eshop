import 'package:eshop/features/fetch_wishlist/domain/fetch_wishlist_class.dart';
import 'package:eshop/utils/utils.dart';

class FetchWishlistRepo{
  Future<List<FetchWishListClass>> getWishlist(String productID)async{
    final List<FetchWishListClass> list=[];
    final data=await FirebaseFirestore.instance.collection("Items").doc(productID).get();
    if(data.exists){
      final FetchWishListClass obj1=FetchWishListClass(image1: data.data()['image1']as String,image2: data.data()['image2']as String,image3: data.data()['image3']as String,image4: data.data()['image4']as String,productName: data.data()['productName']as String,productPrice: data.data()['productPrice']as double,productDescription: data.data()['productDescription']as String,isAvailable: data.data()['isAvailable']as bool,seller: data.data()['seller']as String,productID: data.id);
      list.add(obj1);
    }
    else if(!data.exists){
      final FetchWishListClass obj2=FetchWishListClass(productID:"product do not exist");
      list.add(obj2);
    }
    return list;
  }
}
