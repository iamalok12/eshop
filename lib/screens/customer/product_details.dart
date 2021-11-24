import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/customer/choose_address.dart';
import 'package:eshop/utils/utils.dart';
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
                        (e) => Image.network(
                          e,
                          fit: BoxFit.fill,
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
                          "₹$productPrice",
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
                        try {
                          final data = await FirebaseFirestore.instance
                              .collection("users")
                              .doc(MasterModel.auth.currentUser.email).get();
                          final Map<String,int> result=Map.from(data.data()['cart']as Map<String,dynamic>);
                          if(result.keys.contains(productID)){
                            int amount=result[productID];
                            amount++;
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
                      },
                      style: ElevatedButton.styleFrom(primary: kBlack),
                      child: const Text("Add to cart"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection("Items").doc(productID).get().then((value){
                          if(value.data()['isAvailable']==true){
                            pushNewScreen(
                              context,
                              screen: ChooseAddressSingleOrder(
                              image1:image1,
                              image2:image2,
                              image3:image3,
                              image4:image4,
                              productName:productName,
                              productPrice:productPrice,
                              productDescription:productDescription,
                              seller:seller,
                              productID:productID,
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
