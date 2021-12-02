import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/fetch_cart/bloc/fetch_cart_bloc.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'choose_address.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  Map<String, dynamic> maps={};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Card(
                elevation: 20,
                child: SizedBox(
                  width: 330.w,
                  height: 480.h,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(MasterModel.auth.currentUser.email)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (!snap.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snap.hasError) {
                        return const Center(
                          child: Text("Unable to load cart"),
                        );
                      } else {
                        final Map<String, dynamic> temp =
                            snap.data['cart'] as Map<String, dynamic>;
                        final Map<String, dynamic> map = Map.fromEntries(
                          temp.entries.toList()
                            ..sort(
                              (e1, e2) => e1.key.compareTo(e2.key),
                            ),
                        );
                        maps=map;
                        if(maps.isEmpty){
                          return const Center(
                            child: Text("Cart empty"),
                          );
                        }
                        else{
                          return ListView.builder(
                            itemCount: map.length,
                            itemBuilder: (_, index) {
                              return Center(
                                child: ShoppingCartTile(
                                  key: ObjectKey(map.entries.toList()[index].key),
                                  productID: map.entries.toList()[index].key,
                                  amount: map.entries
                                      .toList()[index]
                                      .value
                                      .toString(),
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: ()async{
                  try{
                    bool allProductAvailable=true;
                    final List<CustomerOrderClass> order=[];
                    for (final element in maps.entries) {
                     final data= await FirebaseFirestore.instance.collection("Items").doc(element.key).get();
                     if(data.exists){
                       if(data.data()['isAvailable']==false){
                         allProductAvailable=false;
                         ErrorHandle.showError("Remove out of stock items");
                         break;
                       }
                       else{
                         final CustomerOrderClass obj=CustomerOrderClass(
                           image1: data.data()['image1'] as String,
                           image2: data.data()['image2'] as String,
                           productName: data.data()['productName'] as String,
                           productID: element.key,
                           productPrice: data.data()['productPrice'] as double,
                           productDescription: data.data()['productDescription'] as String,
                           seller: data.data()['seller'] as String,
                           customerEmail: MasterModel.auth.currentUser.email,
                           quantity: element.value as int,
                         );
                         order.add(obj);
                       }
                     }
                     else{
                       allProductAvailable=false;
                       ErrorHandle.showError("Remove out of stock items");
                       break;
                     }
                    }
                    if(allProductAvailable==true){
                      await Future.delayed(const Duration(milliseconds: 100));
                      if (!mounted) return;
                      if(order.isEmpty){
                        ErrorHandle.showError("Something wrong");
                      }
                      else{
                        pushNewScreen(
                          context,
                          screen: ChooseAddress(
                            orderList: order,
                            isCartToBeEmpty: true,
                          ),
                        );
                      }
                    }
                  }
                  catch(e){
                    ErrorHandle.showError("Something wrong");
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: kPrimary, fixedSize: Size(250.w, 40.h),),
                child: Text(
                  "Checkout",
                  style: TextStyle(fontSize: 15.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingCartTile extends StatelessWidget {
  final String productID;
  final String amount;
  const ShoppingCartTile({Key key, this.productID, this.amount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchCartBloc()..add(FetchCartTriggerEvent(productID)),
      child: Card(
        margin: EdgeInsets.only(bottom: 10.h, left: 5.w, right: 5.w),
        elevation: 20,
        child: Container(
          padding: EdgeInsets.all(3.w),
          height: 120.h,
          width: 300.w,
          child: BlocConsumer<FetchCartBloc, FetchCartState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FetchCartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchCartEmpty) {
                return SizedBox(
                  height: 80.h,
                  width: 280.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Product removed by seller"),
                      IconButton(
                        onPressed: () async {
                          try {
                            final data = await FirebaseFirestore
                                .instance
                                .collection("users")
                                .doc(MasterModel.auth.currentUser.email)
                                .get();
                            final Map<String, dynamic> map = data
                                .data()['cart'] as Map<String, dynamic>;
                            map.remove(state.productID);
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(MasterModel.auth.currentUser.email)
                                .update({"cart": map});
                          } catch (e) {
                            ErrorHandle.showError("Something wrong");
                          }
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              } else if (state is FetchCartLoaded) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: ProductDetail(
                        image1: state.list.first.image1,
                        image2: state.list.first.image2,
                        image3: state.list.first.image3,
                        image4: state.list.first.image4,
                        productName: state.list.first.productName,
                        productPrice: state.list.first.productPrice,
                        productDescription: state.list.first.productDescription,
                        isAvailable: state.list.first.isAvailable,
                        seller: state.list.first.seller,
                        productID: state.list.first.productID,
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 80.h,
                    height: 280.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${state.list.first.productName}          X $amount",
                              style: const TextStyle(color: Colors.blue),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                                "₹ ${(double.parse(amount)*state.list.first.productPrice).toString()}",),
                            SizedBox(
                              height: 10.h,
                            ),
                            if (state.list.first.isAvailable == false)
                              const Text(
                                "Out of stock",
                                style: TextStyle(color: Colors.red),
                              )
                            else
                              const SizedBox()
                          ],
                        ),
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state.list.first.isAvailable == true)
                                IconButton(
                                  onPressed: () async {
                                    try {
                                      final data = await FirebaseFirestore
                                          .instance
                                          .collection("users")
                                          .doc(MasterModel
                                              .auth.currentUser.email,)
                                          .get();
                                      final Map<String, dynamic> map =
                                          data.data()['cart']
                                              as Map<String, dynamic>;
                                      int amount = map[productID] as int;
                                      if (amount <= 4) {
                                        amount++;
                                      } else {
                                        ErrorHandle.showError("Limit exceeded");
                                      }
                                      map[productID] = amount;
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(MasterModel
                                              .auth.currentUser.email,)
                                          .update({"cart": map});
                                    } catch (e) {
                                      ErrorHandle.showError("Something wrong");
                                    }
                                  },
                                  icon: const Icon(Icons.add),
                                )
                              else
                                const SizedBox(),
                              IconButton(
                                onPressed: () async {
                                  try {
                                    final data = await FirebaseFirestore
                                        .instance
                                        .collection("users")
                                        .doc(MasterModel.auth.currentUser.email)
                                        .get();
                                    final Map<String, dynamic> map = data
                                        .data()['cart'] as Map<String, dynamic>;
                                    map.remove(productID);
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(MasterModel.auth.currentUser.email)
                                        .update({"cart": map});
                                  } catch (e) {
                                    ErrorHandle.showError("Something wrong");
                                  }
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              if (state.list.first.isAvailable == true)
                                IconButton(
                                  onPressed: () async {
                                    try {
                                      final data = await FirebaseFirestore
                                          .instance
                                          .collection("users")
                                          .doc(MasterModel
                                              .auth.currentUser.email,)
                                          .get();
                                      final Map<String, dynamic> map =
                                          data.data()['cart']
                                              as Map<String, dynamic>;
                                      int amount = map[productID] as int;
                                      if (amount >= 2) {
                                        amount--;
                                      } else {
                                        ErrorHandle.showError(
                                            "Quantity can not be zero",);
                                      }
                                      map[productID] = amount;
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(MasterModel
                                              .auth.currentUser.email,)
                                          .update({"cart": map});
                                    } catch (e) {
                                      ErrorHandle.showError("Something wrong");
                                    }
                                  },
                                  icon: const Icon(Icons.remove),
                                )
                              else
                                const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text("Unable to fetch"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
