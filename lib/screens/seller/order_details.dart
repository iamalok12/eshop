import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final String orderID;
  const OrderDetails({Key key, this.orderID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("orders").doc(orderID).get(),
          builder: (context,AsyncSnapshot<DocumentSnapshot> snap){
            if(!snap.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snap.hasError){
              return const Center(
                child: Text("Something wrong"),
              );
            }
            else{
              final obj=OrderModel.fromJson(snap.data.data() as Map<String,dynamic>);
              String statusHandler({bool cCustomer,bool cSeller,bool shipped,bool delivered}){
                if(cCustomer==true){
                  return "Order cancelled by customer";
                }
                else if(cSeller==true){
                  return "Order cancelled by you";
                }
                else if(delivered==true){
                  return "Delivered";
                }
                else if(shipped==true){
                  return "Shipped";
                }
                else{
                  return "Order placed";
                }
              }
              return Center(
                child:Card(
                  elevation: 40,
                  child: SizedBox(
                    width: 300.w,
                    height: 400.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 80.w,
                              width: 80.w,
                              child: CachedNetworkImage(
                                imageUrl: obj.image1,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            Column(
                              children: [
                                Text("${obj.productName}: X${obj.quantity}",style: TextStyle(color: kPrimary,fontSize: 18.sp),),
                                SizedBox(height: 10.h,),
                                Text("₹${obj.productPrice*obj.quantity}",style: TextStyle(color: kPrimary,fontSize: 18.sp),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Text("Status: ${statusHandler(cCustomer: obj.cancelledByCustomer,cSeller: obj.cancelledBySeller,shipped: obj.shipped,delivered: obj.delivered)}",style:TextStyle(color: Colors.blue,fontSize: 15.sp),),
                        SizedBox(height: 5.h,),
                        Text("Address: ${obj.address}"),
                        SizedBox(height: 5.h,),
                        Text("Order time: ${obj.orderTime.day}/${obj.orderTime.month}/${obj.orderTime.year} ${obj.orderTime.hour}:${obj.orderTime.minute}",style: const TextStyle(color: Colors.deepOrange),),
                        SizedBox(height: 5.h,),
                        Center(
                          child: Container(
                            height: 80.h,
                            width: 280.w,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection("users").doc(obj.seller).snapshots(),
                              builder: (context,AsyncSnapshot snap){
                                if(!snap.hasData){
                                  return const CircularProgressIndicator();
                                }
                                else if(snap.hasError){
                                  return const Text("Error fetching seller");
                                }
                                else{
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Shop name: ${snap.data['name'].toString()}"),
                                        Text("Mobile: ${snap.data['mobile'].toString()}"),
                                        Text("E-Mail: ${obj.seller}"),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
