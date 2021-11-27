import 'package:eshop/models/order_model.dart';
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
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(obj.productName),
                    Text(obj.productPrice.toString()),
                    Text(obj.productDescription),
                    Text(obj.address),
                    Text(obj.quantity.toString()),
                    Text(obj.orderTime.toLocal().toString()),
                    Text("Status: ${statusHandler(cCustomer: obj.cancelledByCustomer,cSeller: obj.cancelledBySeller,shipped: obj.shipped,delivered: obj.delivered)}",style:TextStyle(color: Colors.blue,fontSize: 15.sp),),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
