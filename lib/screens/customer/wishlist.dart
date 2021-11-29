import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/features/fetch_wishlist/bloc/fetch_wishlist_bloc.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/customer/product_details.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}
class _WishListState extends State<WishList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(MasterModel.auth.currentUser.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final List list = snap.data['wishList'] as List<dynamic>;
              if (list.isEmpty) {
                return const Center(
                  child: Text("Wishlist empty"),
                );
              } else {
                return ListView(
                  children: list
                      .map(
                        (e) => WishlistTile(productID: e.toString(),key: ObjectKey(e.toString()),),
                      )
                      .toList(),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class WishlistTile extends StatelessWidget {
  final String productID;
  const WishlistTile({Key key, this.productID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchWishlistBloc()..add(FetchWishListTriggerEvent(productID)),
      child: Card(
        margin: EdgeInsets.only(bottom: 10.h,left: 5.w,right: 5.w),
        elevation: 20,
        child: Container(
          padding: EdgeInsets.all(3.w),
          height: 80.h,
          width: 300.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 290.w,
                child: BlocConsumer<FetchWishlistBloc,FetchWishlistState>(
                  listener: (context,state){},
                  builder: (context,state){
                    if(state is FetchWishlistLoading){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    else if (state is FetchWishlistEmpty){
                      return const Center(child: Text("Product removed by seller"),);
                    }
                    else if(state is FetchWishlistLoaded){
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          pushNewScreen(context, screen: ProductDetail(
                            image1:state.list.first.image1,
                            image2:state.list.first.image2,
                            image3:state.list.first.image3,
                            image4:state.list.first.image4,
                            productName:state.list.first.productName,
                            productPrice:state.list.first.productPrice,
                            productDescription:state.list.first.productDescription,
                            isAvailable:state.list.first.isAvailable,
                            seller:state.list.first.seller,
                            productID:state.list.first.productID,
                          ),);
                        },
                        child: SizedBox(
                          width: 80.h,
                          height: 300.w,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 80.w,
                                width: 80.w,
                                child: CachedNetworkImage(
                                  imageUrl: state.list.first.image1,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                              SizedBox(width: 20.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.list.first.productName),
                                  SizedBox(height: 10.h,),
                                  Text("₹ ${state.list.first.productPrice.toString()}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    else{
                      return const Center(child: Text("Unable to fetch"),);
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: ()async{
                  try{
                    final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
                    final List<dynamic> tempList=data.data()['wishList']as List<dynamic>;
                    tempList.remove(productID);
                    await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
                      "wishList":tempList
                    });
                  }
                  catch(e){
                    ErrorHandle.showError("Something wrong");
                  }

                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
