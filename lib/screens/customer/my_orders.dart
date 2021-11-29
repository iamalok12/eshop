import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/models/order_model.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  String statusHandler({bool cCustomer,bool cSeller,bool shipped,bool delivered}){
    if(cCustomer==true){
      return "Order cancelled by you";
    }
    else if(cSeller==true){
      return "Order cancelled by seller";
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("orders").where("customer",isEqualTo:MasterModel.auth.currentUser.email).snapshots(),
          builder: (context,snap){
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
            else if(snap.data==null){
              return const Center(
                child: Text("No orders placed yet"),
              );
            }
            else{
              final List<OrderModel> orderList=[];
              for(int i=0;i<snap.data.size;i++){
                final data=OrderModel.fromJson(snap.data.docs[i].data() as Map<String,dynamic>);
                orderList.add(data);
              }
              orderList.sort((a,b)=>a.orderTime.compareTo(b.orderTime));
              if(orderList.isEmpty){
                return const Center(
                  child: Text("No orders yet"),
                );
              }
              else{
                return ListView(
                  children: orderList.map((e) =>Card(
                    elevation: 20,
                    margin: EdgeInsets.only(left: 5.w,right: 5.w,bottom: 10.h),
                    child:Center(
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        width: 320.w,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 80.w,
                                    width: 80.w,
                                    child: CachedNetworkImage(
                                      imageUrl: e.image1,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: 20.w,),
                                  Column(
                                    children: [
                                      Text("${e.productName}: X${e.quantity}",style: TextStyle(color: kPrimary,fontSize: 18.sp),),
                                      SizedBox(height: 10.h,),
                                      Text("₹${e.productPrice*e.quantity}",style: TextStyle(color: kPrimary,fontSize: 18.sp),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Text("Status: ${statusHandler(cCustomer: e.cancelledByCustomer,cSeller: e.cancelledBySeller,shipped: e.shipped,delivered: e.delivered)}",style:TextStyle(color: Colors.blue,fontSize: 15.sp),),
                              SizedBox(height: 5.h,),
                              Text("Address: ${e.address}"),
                              SizedBox(height: 5.h,),
                              Text("Order time: ${e.orderTime.day}/${e.orderTime.month}/${e.orderTime.year} ${e.orderTime.hour}:${e.orderTime.minute}",style: const TextStyle(color: Colors.deepOrange),),
                              SizedBox(height: 5.h,),
                              Center(
                                child: Container(
                                  height: 80.h,
                                  width: 280.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection("users").doc(e.seller).snapshots(),
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
                                              Text("E-Mail: ${e.seller}"),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(onPressed:()async{
                                    if(e.cancelledBySeller==false && e.delivered==false){
                                      try{
                                        await FirebaseFirestore.instance.collection("orders").doc(e.orderId).update({
                                          "cancelledByCustomer":true
                                        });
                                      }
                                      catch(e){
                                        ErrorHandle.showError("Something wrong");
                                      }
                                    }
                                    else{
                                      ErrorHandle.showError("Can not cancel");
                                    }
                                  },style: ElevatedButton.styleFrom(primary: Colors.red.shade400,fixedSize: Size(120.w,20.h)), child: const Text("Cancel"),),
                                  ElevatedButton(onPressed:()async{
                                    if(e.cancelledBySeller==false && e.cancelledByCustomer==false&& e.shipped==true){
                                      try{
                                        await FirebaseFirestore.instance.collection("orders").doc(e.orderId).update({
                                          "delivered":true
                                        });
                                      }
                                      catch(e){
                                        ErrorHandle.showError("Something wrong");
                                      }
                                    }
                                    else{
                                      ErrorHandle.showError("Can not mark delivered");
                                    }
                                  },style: ElevatedButton.styleFrom(primary: Colors.green.shade400,fixedSize: Size(120.w,20.h)), child: const Text("Mark delivered"),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),).toList(),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
