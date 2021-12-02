import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/fetch_items_shop/bloc/fetch_products_bloc.dart';
import 'package:eshop/features/fetch_items_shop/domain/seller_item_class.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ShopPanel extends StatefulWidget {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String shopName;
  final String owner;
  final String mobileNumber;
  final String area;
  final String locality;
  final String city;
  final String pinCode;
  final String ownerEmail;
  const ShopPanel({Key key, this.image1, this.image2, this.image3, this.image4, this.shopName, this.owner, this.mobileNumber, this.area, this.locality, this.city, this.pinCode, this.ownerEmail}) : super(key: key);
  @override
  _ShopPanelState createState() => _ShopPanelState();
}

class _ShopPanelState extends State<ShopPanel> {
  List<SellerItemsClass> list=[];
  List<SellerItemsClass> searchList=[];
  final _search = TextEditingController();

  Future<void> onSearch(String text) async {
    searchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (final element in list) {
      if (element.productName.toLowerCase().contains(text.toLowerCase())) {
        searchList.add(element);
      }
    }
    setState(() {});
  }

  Widget mainBody() {
    if (searchList.isNotEmpty && _search.text.isNotEmpty) {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: list.map((e) => ItemTiles(
          image1: e.image1,
          image2: e.image2,
          image3: e.image3,
          image4: e.image4,
          productName: e.productName,
          productPrice: e.productPrice,
          productDescription: e.productDescription,
          seller: e.seller,
          productID: e.productID,
          isAvailable: e.isAvailable,
        ),).toList(),
      );
    } else if (searchList.isEmpty && _search.text.isNotEmpty) {
      return const Center(
        child: Text("No result found"),
      );
    } else {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: list.map((e) => ItemTiles(
          image1: e.image1,
          image2: e.image2,
          image3: e.image3,
          image4: e.image4,
          productName: e.productName,
          productPrice: e.productPrice,
          productDescription: e.productDescription,
          seller: e.seller,
          productID: e.productID,
          isAvailable: e.isAvailable,
        ),).toList(),
      );
    }
  }
  Future<void>refreshPage()async {
    FetchProductsBloc().add(FetchProductTrigger(widget.ownerEmail));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50.h,bottom: 5.h),
                  height: 200.h,
                  width: double.infinity,
                  color: kBlack,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              widget.shopName,
                              style: TextStyle(fontSize: 18.sp, color: kWhite),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 320.w,child: const Divider(thickness: 3,color: Colors.white70),),
                            Text(
                              "${widget.area}, ${widget.locality}, ${widget.city}\n Pincode: ${widget.pinCode}\n Mobile: ${widget.mobileNumber}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13.sp, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 240.w,
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: TextFormField(
                              controller: _search,
                              onChanged: onSearch,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                hintText: "Search products",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: Center(
                                      child: Container(
                                        color: kWhite,
                                        height: 250.h,
                                        width: 250.w,
                                        padding: EdgeInsets.all(15.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Sort by",
                                                  style: TextStyle(fontSize: 25.sp),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.cancel),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 3.h,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              "Name",
                                              style: TextStyle(fontSize: 20.sp),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      list.sort((a, b) {
                                                        return a.productName.toLowerCase().compareTo(b.productName.toLowerCase());
                                                      });
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: kPrimary,),
                                                  child: const Text("A"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      list.sort((b, a) {
                                                        return a.productName.toLowerCase().compareTo(b.productName.toLowerCase());
                                                      });
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: kBlack,),
                                                  child: const Text("Z"),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 3.h,
                                              color: kPrimary,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              "Price",
                                              style: TextStyle(fontSize: 20.sp),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      list.sort((a, b) {
                                                        return a.productPrice.compareTo(b.productPrice);
                                                      });
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: kPrimary,),
                                                  child: const Text("Low"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      list.sort((b, a) {
                                                        return a.productPrice.compareTo(b.productPrice);
                                                      });
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: kBlack,),
                                                  child: const Text("High"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.sort,
                              color: kWhite,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 80.w,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    height: 320.w,
                    width: 320.w,
                    child: ImageSlideshow(
                      children: [
                        widget.image1,
                        widget.image2,
                        widget.image3,
                        widget.image4,
                      ].map((e) => CachedNetworkImage(
                        imageUrl: e,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),).toList(),
                    ),
                  ),
                ),
                // SizedBox(height: 10.h,),
                SizedBox(
                  width: 320.w,
                  child: BlocProvider(
                    create: (context) => FetchProductsBloc()..add(FetchProductTrigger(widget.ownerEmail)),
                    child: BlocConsumer<FetchProductsBloc,FetchProductsState>(
                      listener: (context,state){
                        if(state is FetchProductsLoaded){
                          setState(() {
                            list.clear();
                            list=state.list;
                          });
                        }
                      },
                      builder: (context,state){
                        if(state is FetchProductsLoading){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else if(state is FetchProductsEmpty){
                          return const Center(child: Text("Shop is yet to add products"),);
                        }
                        else if(state is FetchProductsLoaded){
                          return mainBody();
                        }
                        else if(state is FetchProductsError){
                          return const Center(child: Text("Unable to fetch Items"),);
                        }
                        else{
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemTiles extends StatelessWidget {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String productName;
  final double productPrice;
  final String productDescription;
  final bool isAvailable;
  final String seller;
  final String productID;

  const ItemTiles({Key key,this.productID, this.image1, this.image2, this.image3, this.image4, this.productName, this.productPrice, this.productDescription, this.isAvailable, this.seller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNewScreen(
          context,
          screen: ProductDetail(
            productID: productID,
            productName: productName,
            productPrice: productPrice,
            productDescription: productDescription,
            image1: image1,
            image2: image2,
            image3: image3,
            image4: image4,
            isAvailable: isAvailable,
            seller: seller,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Card(
          elevation: 30,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
            width: 320.w,
            height: 80.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  imageUrl: image1,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "₹ $productPrice",
                        style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: isAvailable==true?Colors.green:Colors.red,
                    size: 30.w,
                  ),
                  onPressed: () async{
                    if(isAvailable){
                      try{
                        final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
                        final Map<String,int> result=Map.from(data.data()['cart']as Map<String,dynamic>);
                        if(result.keys.contains(productID)){
                          int amount=result[productID];
                          if(amount<=4){
                            amount++;
                          }
                          else{
                            ErrorHandle.showError("Limit exceeded");
                          }
                          result[productID]=amount;
                        }
                        else {
                          result[productID] = 1;
                        }
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(MasterModel.auth.currentUser.email).update({
                          "cart":result
                        }).then((value){
                          ErrorHandle.showError("Added to cart");
                        });
                      }
                      catch(e){
                        ErrorHandle.showError("Something wrong");
                      }
                    }
                    else{
                      ErrorHandle.showError("Out of stock");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
