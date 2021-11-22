import 'package:eshop/features/fetch_wishlist/bloc/fetch_wishlist_bloc.dart';
import 'package:eshop/features/fetch_wishlist/domain/fetch_wishlist_class.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/customer/product_details.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// class WishList extends StatefulWidget {
//   @override
//   _WishListState createState() => _WishListState();
// }
// class _WishListState extends State<WishList> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection("users")
//               .doc(MasterModel.auth.currentUser.email)
//               .snapshots(),
//           builder: (BuildContext context, AsyncSnapshot snap) {
//             if (!snap.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
//               final List list = snap.data['wishList'] as List<dynamic>;
//               if (list.isEmpty) {
//                 return const Center(
//                   child: Text("Wishlist empty"),
//                 );
//               } else {
//                 return ListView(
//                   children: list
//                       .map(
//                         (e) => WishlistTile(productID: e.toString(),),
//                       )
//                       .toList(),
//                 );
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class WishlistTile extends StatelessWidget {
//   final String productID;
//   const WishlistTile({Key key, this.productID}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => FetchWishlistBloc()..add(FetchWishListTriggerEvent(productID)),
//       child: Card(
//         margin: EdgeInsets.only(bottom: 10.h,left: 5.w,right: 5.w),
//         elevation: 20,
//         child: Container(
//           padding: EdgeInsets.all(3.w),
//           height: 80.h,
//           width: 300.w,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 290.w,
//                 child: BlocConsumer<FetchWishlistBloc,FetchWishlistState>(
//                   listener: (context,state){},
//                   builder: (context,state){
//                     if(state is FetchWishlistLoading){
//                       return const Center(child: CircularProgressIndicator(),);
//                     }
//                     else if (state is FetchWishlistEmpty){
//                       return const Center(child: Text("Product removed by seller"),);
//                     }
//                     else if(state is FetchWishlistLoaded){
//                       return GestureDetector(
//                         behavior: HitTestBehavior.opaque,
//                         onTap: () {
//                           pushNewScreen(context, screen: ProductDetail(
//                             image1:state.list.first.image1,
//                             image2:state.list.first.image2,
//                             image3:state.list.first.image3,
//                             image4:state.list.first.image4,
//                             productName:state.list.first.productName,
//                             productPrice:state.list.first.productPrice,
//                             productDescription:state.list.first.productDescription,
//                             isAvailable:state.list.first.isAvailable,
//                             seller:state.list.first.seller,
//                             productID:state.list.first.productID,
//                           ),);
//                         },
//                         child: SizedBox(
//                           width: 80.h,
//                           height: 300.w,
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 height: 80.w,
//                                 width: 80.w,
//                                 child: Image.network(state.list.first.image1,fit: BoxFit.fill,),
//                               ),
//                               SizedBox(width: 20.w,),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(state.list.first.productName),
//                                   SizedBox(height: 10.h,),
//                                   Text("₹ ${state.list.first.productPrice.toString()}"),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                     else{
//                       return const Center(child: Text("Unable to fetch"),);
//                     }
//                   },
//                 ),
//               ),
//               IconButton(
//                 onPressed: ()async{
//                   print(productID);
//                   final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
//                   final List<dynamic> tempList=data.data()['wishList']as List<dynamic>;
//                   tempList.remove(productID);
//                   print(tempList.first);
//                   await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
//                     "wishList":tempList
//                   });
//                 },
//                 icon: const Icon(Icons.delete),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

enum Status { loading, error, empty, loaded }

class FavoriteItems extends StatefulWidget {
  @override
  _FavoriteItemsState createState() => _FavoriteItemsState();
}

class _FavoriteItemsState extends State<FavoriteItems> {
  List<FetchWishListClass> list = [];
  Status status = Status.loading;

  Future<void> getItems() async {
    list.clear();
    try {
      final data = await FirebaseFirestore.instance
          .collection("users")
          .doc(MasterModel.auth.currentUser.email)
          .get();
      final List tempList = data.data()['wishList'] as List<dynamic>;
      print(tempList.length);
      if (tempList.isEmpty) {
        setState(() {
          status = Status.empty;
        });
        return;
      } else {
        for (int i = 0; i < tempList.length; i++) {
          final result = await FirebaseFirestore.instance
              .collection("Items")
              .doc(tempList[i].toString())
              .get();
          if (result.exists) {
            final FetchWishListClass obj1 = FetchWishListClass(
                image1: result.data()['image1'] as String,
                image2: result.data()['image2'] as String,
                image3: result.data()['image3'] as String,
                image4: result.data()['image4'] as String,
                productName: result.data()['productName'] as String,
                productPrice: result.data()['productPrice'] as double,
                productDescription:
                    result.data()['productDescription'] as String,
                isAvailable: result.data()['iaAvailable'] as bool,
                seller: result.data()['seller'] as String,
                productID: result.id);
            list.add(obj1);
          } else if (!result.exists) {
            final FetchWishListClass obj2 =
                FetchWishListClass(image1: "product do not exist");
            list.add(obj2);
          }
        }
      }

      setState(() {
        status = Status.loaded;
      });
    } catch (e) {
      setState(() {
        status = Status.error;
      });
    }
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getWidget(),
      ),
    );
  }

  Widget getWidget() {
    if (status == Status.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (status == Status.empty) {
      return const Center(
        child: Text("Favorites empty"),
      );
    } else if (status == Status.error) {
      return const Center(
        child: Text("Unable to fetch data"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (_, index) {
          if(list[index].image1=="product do not exist"){
            return const Text("Product do not exist");
          }
          else{
            return Card();
          }
        },
        itemCount: list.length,
      );
    }
  }
}
