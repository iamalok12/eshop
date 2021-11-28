import 'package:eshop/features/fetch_orders/bloc/fetch_order_seller_bloc.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/models/notification_trigger.dart';
import 'package:eshop/models/order_model.dart';
import 'package:eshop/screens/notification/notification_page.dart';
import 'package:eshop/screens/seller/order_details.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class SellerHome extends StatefulWidget {
  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
 final NotificationTrigger _notificationTrigger=NotificationTrigger();
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
 List<OrderModel> list=[];
 List<OrderModel> searchList=[];
 final _search = TextEditingController();

 Future<void> onSearch(String text) async {
   print(text);
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
       children: searchList.map((e) => GestureDetector(
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
                     if(e.cancelledBySeller==false && e.cancelledByCustomer==false&& e.delivered==false&&e.shipped==false){
                       try{
                         _notificationTrigger.trigger(recipient:e.customer,orderID: e.orderId,title:"Order shipped",body:e.productName,);
                         await FirebaseFirestore.instance.collection("orders").doc(e.orderId).update({
                           "shipped":true
                         }).then((value){
                           BlocProvider.of<FetchOrderSellerBloc>(context)
                               .add(FetchOrderTrigger());
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
   } else if (searchList.isEmpty && _search.text.isNotEmpty) {
     return const Center(
       child: Text("No result found"),
     );
   } else {
     return ListView(
       children: list.map((e) => GestureDetector(
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
                     if(e.cancelledBySeller==false && e.cancelledByCustomer==false&& e.delivered==false&&e.shipped==false){
                       try{
                         _notificationTrigger.trigger(recipient:e.customer,orderID: e.orderId,title:"Order shipped",body:e.productName,);
                         await FirebaseFirestore.instance.collection("orders").doc(e.orderId).update({
                           "shipped":true
                         }).then((value){
                           BlocProvider.of<FetchOrderSellerBloc>(context)
                               .add(FetchOrderTrigger());
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
                controller: _search,
                onChanged: onSearch,
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
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).snapshots(),
                      builder: (context,AsyncSnapshot snap){
                        Icon showIcon(){
                          bool isNotificationViewed;
                          if(snap.hasData){
                            final bool isNotificationRead=snap.data['isNotificationSeen'] as bool;
                            isNotificationViewed=isNotificationRead;
                          }
                          if(isNotificationViewed==false){
                            return const Icon(Icons.notification_important,color: Colors.red,);
                          }
                          else{
                            return const Icon(Icons.notifications);
                          }
                        }
                        return IconButton(
                          onPressed: () {
                            pushNewScreen(context, screen: NotificationPage());
                          },
                          icon: showIcon(),
                        );
                      },
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
              ),
            ),
          ],
        ),
      ),
      body:BlocProvider(
        create: (context) => FetchOrderSellerBloc()..add(FetchOrderTrigger()),
        child: BlocConsumer<FetchOrderSellerBloc,FetchOrderSellerState>(
          listener: (context,state){
            if(state is FetchOrderSellerLoaded){
              setState(() {
                list=state.list;
              });
            }
          },
          builder: (context,state){
            if(state is FetchOrderSellerLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(state is FetchOrderSellerLoaded){
              return mainBody();
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
