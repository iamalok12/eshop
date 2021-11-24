import 'dart:collection';

import 'package:eshop/features/fetch_cart/bloc/fetch_cart_bloc.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/customer/product_details.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ShoppingCart extends StatefulWidget {

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
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
                    stream: FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).snapshots(),
                    builder: (BuildContext context,AsyncSnapshot snap){
                      if(!snap.hasData){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else if(snap.hasError){
                        return const Center(
                          child: Text("Unable to load cart"),
                        );
                      }
                      else{
                        final Map<String, dynamic> temp=snap.data['cart']as Map<String,dynamic>;
                        final Map<String, dynamic> map = Map.fromEntries(temp.entries.toList()..sort((e1, e2) =>
                            e1.key.compareTo(e2.key),),);
                        return ListView.builder(
                          itemCount: map.length,
                          itemBuilder: (_,index){
                            return ShoppingCartTile(
                              key: ObjectKey(map.entries.toList()[index].key),
                              productID: map.entries.toList()[index].key,
                              amount: map.entries.toList()[index].value.toString(),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(primary: kPrimary,fixedSize: Size(250.w,40.h)), child: Text("Checkout",style: TextStyle(fontSize: 15.sp),),)
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
  const ShoppingCartTile({Key key, this.productID,this.amount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchCartBloc()..add(FetchCartTriggerEvent(productID)),
      child: Card(
        margin: EdgeInsets.only(bottom: 10.h,left: 5.w,right: 5.w),
        elevation: 20,
        child: Container(
          padding: EdgeInsets.all(3.w),
          height: 120.h,
          width: 270.w,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250.w,
                  child: BlocConsumer<FetchCartBloc,FetchCartState>(
                    listener: (context,state){},
                    builder: (context,state){
                      if(state is FetchCartLoading){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      else if (state is FetchCartEmpty){
                        return const Center(child: Text("Product removed by seller"),);
                      }
                      else if(state is FetchCartLoaded){
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
                            height: 270.w,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 80.w,
                                  width: 80.w,
                                  child: Image.network(state.list.first.image1,fit: BoxFit.fill,),
                                ),
                                SizedBox(width: 20.w,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${state.list.first.productName}          X $amount",style: const TextStyle(color: Colors.blue),),
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
                SizedBox(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: ()async{
                          try{
                            final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
                            final Map<String, dynamic> map=data.data()['cart']as Map<String,dynamic>;
                            int amount=map[productID] as int;
                            if(amount<=4){
                              amount++;
                            }
                            else{
                              ErrorHandle.showError("Limit exceeded");
                            }
                            map[productID]=amount;
                            await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
                              "cart":map
                            });
                          }
                          catch(e){
                            print(e);
                            ErrorHandle.showError("Something wrong");
                          }
                        },
                        icon: const Icon(Icons.arrow_upward),
                      ),
                      IconButton(
                        onPressed: ()async{
                          try{
                            final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
                            final Map<String, dynamic> map=data.data()['cart']as Map<String,dynamic>;
                            map.remove(productID);
                            await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
                              "cart":map
                            });
                          }
                          catch(e){
                            ErrorHandle.showError("Something wrong");
                          }

                        },
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: ()async{
                          try{
                            final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
                            final Map<String, dynamic> map=data.data()['cart']as Map<String,dynamic>;
                            int amount=map[productID] as int;
                            if(amount>=2){
                              amount--;
                            }
                            else{
                              ErrorHandle.showError("Quantity can not be zero");
                            }
                            map[productID]=amount;
                            await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
                              "cart":map
                            });
                          }
                          catch(e){
                            ErrorHandle.showError("Something wrong");
                          }
                        },
                        icon: const Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
