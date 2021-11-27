import 'package:eshop/features/fetch_orders/bloc/fetch_order_seller_bloc.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/models/notification_trigger.dart';
import 'package:eshop/screens/seller/order_details.dart';
import 'package:eshop/utils/app_constants.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../main.dart';

class SellerHome extends StatefulWidget {
  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
 FirebaseMessaging messaging;
 final NotificationTrigger _notificationTrigger=NotificationTrigger();
 @override
 void initState() {
   super.initState();
   messaging = FirebaseMessaging.instance;
   messaging.subscribeToTopic("seller");
   messaging.getToken().then((value)async{
     final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
     if(data.data()['notificationKey']!=value){
       await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
         'notificationKey':value
       });
     }
   });
   FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
     final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
     final Map<String, dynamic> temp =
     data.data()['notification'] as Map<String, dynamic>;
     temp[DateTime.now().microsecondsSinceEpoch.toString()]=event.data['orderId'];
     await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
       "notification":temp
     });
     final RemoteNotification notification = event.notification;
     final AndroidNotification android = event.notification?.android;
     if (notification != null && android != null) {
       flutterLocalNotificationsPlugin.show(
         0,
         notification.title,
         notification.body,
         NotificationDetails(
           android: AndroidNotificationDetails(
             channel.id,
             channel.name,
             color: Colors.blue,
             channelDescription: channel.description,
             icon: '@mipmap/ic_launcher',
           ),
         ),
       );
     }
   });
   FirebaseMessaging.onMessageOpenedApp.listen((message) {
     debugPrint("message read");
   });
 }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: Row(
          children: [
            SizedBox(
              width: 2.w,
            ),
            Container(
              width: 240.w,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Search orders",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        color: kWhite,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Center(
                                child: Container(
                                  color: kWhite,
                                  height: 350.h,
                                  width: 250.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SecondaryButton(
                                        label: "Cancel",
                                        callback: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      PrimaryButton(
                                        label: "Apply",
                                        callback: () {},
                                      )
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
              ),
            ),
          ],
        ),
      ),
      body:BlocProvider(
        create: (context) => FetchOrderSellerBloc()..add(FetchOrderTrigger()),
        child: BlocConsumer<FetchOrderSellerBloc,FetchOrderSellerState>(
          listener: (context,state){},
          builder: (context,state){
            if(state is FetchOrderSellerLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(state is FetchOrderSellerLoaded){
              return ListView(
                children: state.list.map((e) => GestureDetector(
                  onTap: (){
                    pushNewScreen(context, screen: OrderDetails(orderID: e.orderId,));
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Card(
                    margin: EdgeInsets.only(left: 5.w,right: 5.w,bottom: 10.w),
                    elevation: 20,
                    child: Container(
                      width: 300.w,
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${e.productName}  X${e.quantity}",style: TextStyle(fontSize: 18.sp,color: kPrimary),),
                              Text("${e.orderTime.day}/${e.orderTime.month}/${e.orderTime.year}  ${e.orderTime.hour}:${e.orderTime.minute}")
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Text("₹${e.productPrice}",style: TextStyle(fontSize: 18.sp,color: kPrimary),),
                          SizedBox(height: 5.h,),
                          Text(e.address),
                          SizedBox(height: 5.h,),
                          Text("Status: ${statusHandler(cCustomer: e.cancelledByCustomer,cSeller: e.cancelledBySeller,shipped: e.shipped,delivered: e.delivered)}",style:TextStyle(color: Colors.blue,fontSize: 15.sp),),
                          Center(
                            child: ElevatedButton(onPressed:()async{
                              if(e.cancelledBySeller==false && e.cancelledByCustomer==false&& e.delivered==false){
                                try{
                                  _notificationTrigger.trigger(recipient:e.customer,productID: e.productId,title:"Order shipped",body:e.productName,);
                                  await FirebaseFirestore.instance.collection("orders").doc(e.orderId).update({
                                    "shipped":true
                                  });
                                }
                                catch(e){
                                  ErrorHandle.showError("Something wrong");
                                }
                              }
                              else{
                                ErrorHandle.showError("Can not mark shipped");
                              }
                            },style: ElevatedButton.styleFrom(primary: Colors.green.shade400,fixedSize: Size(120.w,20.h)), child: const Text("Mark shipped"),),
                          ),
                          Center(
                            child: ElevatedButton(onPressed:()async{
                              if(e.cancelledBySeller==false && e.cancelledByCustomer==false&& e.delivered==false){
                                try{
                                  await FirebaseFirestore.instance.collection("orders").doc(e.orderId).update({
                                    "cancelledBySeller":true
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),).toList(),
              );
            }
            else if(state is FetchOrderSellerEmpty){
              return const Center(
                child: Text("No orders yet"),
              );
            }
            else if(state is FetchOrderSellerError){
              return const Center(
                child: Text("Unable to fetch data"),
              );
            }
            else{
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
