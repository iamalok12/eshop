import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProductDetail extends StatelessWidget {
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

  const ProductDetail({
    Key key,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.isAvailable,
    this.seller,
    this.productID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.width,
                width: size.width,
                child: ImageSlideshow(
                  children: [
                    image1,
                    image2,
                    image3,
                    image4,
                  ].map(
                        (e) => CachedNetworkImage(
                          imageUrl: e,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ).toList(),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 300.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(fontSize: 18.sp, color: kPrimary),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "???$productPrice",
                          style: TextStyle(fontSize: 18.sp, color: kBlack),
                        ),
                      ],
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(MasterModel.auth.currentUser.email)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          final List<dynamic> list =
                              snap.data['wishList'] as List<dynamic>;
                          if (list.contains(productID)) {
                            return IconButton(
                              icon: Icon(
                                Icons.favorite,
                                size: 30.w,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                list.remove(productID);
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(MasterModel.auth.currentUser.email)
                                    .update({"wishList": list});
                              },
                            );
                          } else {
                            return IconButton(
                              icon: Icon(
                                Icons.favorite,
                                size: 30.w,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                list.add(productID);
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(MasterModel.auth.currentUser.email)
                                    .update({"wishList": list});
                              },
                            );
                          }
                        } else {
                          return Icon(
                            Icons.favorite,
                            size: 30.w,
                            color: Colors.black,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 100.h,
                width: 320.w,
                decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Colors.black12,),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    productDescription,
                    style: TextStyle(fontSize: 15.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 320.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if(isAvailable){
                          try {
                            final data = await FirebaseFirestore.instance
                                .collection("users")
                                .doc(MasterModel.auth.currentUser.email).get();
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
                          } catch (e) {
                            ErrorHandle.showError("Something wrong");
                          }
                        }
                        else{
                          ErrorHandle.showError("Out of stock");
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: kBlack),
                      child: const Text("Add to cart"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection("Items").doc(productID).get().then((value){
                          if(value.data()['isAvailable']==true){
                            final List<CustomerOrderClass> order=[];
                            final CustomerOrderClass obj=CustomerOrderClass(
                              image1: image1,
                              image2: image2,
                              productName: productName,
                              productID: productID,
                              productPrice: productPrice,
                              productDescription: productDescription,
                              seller: seller,
                              customerEmail: MasterModel.auth.currentUser.email,
                              quantity: 1,
                            );
                            order.add(obj);
                            pushNewScreen(
                              context,
                              screen: ChooseAddress(
                              orderList: order,
                              ),
                            );
                          }
                          else{
                            ErrorHandle.showError("Out of stock");
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(primary: kPrimary),
                      child: const Text("Buy now"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
