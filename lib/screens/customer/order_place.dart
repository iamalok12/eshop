import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/customer_order.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/customer/customer_root.dart';
import 'package:eshop/utils/colorpallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OrderPlace extends StatefulWidget {
  final String address;
  final List<CustomerOrderClass> orderList;
  const OrderPlace({
    Key key,
    this.address,
    this.orderList,
  }) : super(key: key);
  @override
  _OrderPlaceState createState() => _OrderPlaceState();
}

class _OrderPlaceState extends State<OrderPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Confirm Order",
                style: TextStyle(fontSize: 30.sp, color: Colors.green),
              ),
              SizedBox(
                height: 20.h,
              ),
              Card(
                elevation: 40.w,
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  height: 100.h,
                  width: 300.w,
                  child: Center(
                    child:Column(
                      children: [
                        Text("Address",style: TextStyle(color: Colors.blue,fontSize: 20.sp),),
                        Text(widget.address),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 270.h,
                width: 300.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: ListView(
                  children: widget.orderList.map((e) => OrderTile(
                    image1: e.image1,
                    productName: e.productName,
                    productPrice: e.productPrice,
                    quantity: e.quantity,
                  ),).toList(),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  try{
                    for(int i=0;i<widget.orderList.length;i++){
                      await FirebaseFirestore.instance
                          .collection("Items")
                          .doc(widget.orderList[i].productID)
                          .get()
                          .then((value) async {
                        if (value.data()['isAvailable'] == true) {
                          await FirebaseFirestore.instance
                              .collection("orders")
                              .doc()
                              .set({
                            "address": widget.address,
                            "image1": widget.orderList[i].image1,
                            "image2": widget.orderList[i].image2,
                            "productName": widget.orderList[i].productName,
                            "productPrice": widget.orderList[i].productPrice,
                            "productDescription": widget.orderList[i].productDescription,
                            "seller": widget.orderList[i].seller,
                            "customer": MasterModel.auth.currentUser.email,
                            "productId": widget.orderList[i].productID,
                            "quantity":widget.orderList[i].quantity,
                            "shipped":false,
                            "delivered":false
                          });
                        } else {
                          ErrorHandle.showError("Some product went out of stock while ordering");
                        }
                      });
                    }
                    showDialog(
                      context: context,
                      builder: (_) {
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              height: 300.w,
                              width: 200.w,
                              color: kWhite,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Success",style: TextStyle(fontSize: 25.sp),),
                                    SizedBox(
                                      height: 150.w,
                                      width: 150.w,
                                      child: Lottie.asset(
                                        "assets/images/success.json",
                                        fit: BoxFit.fill,),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => CustomerRoot(),),);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(100.w, 20.h),
                                      ),
                                      child: const Text("Go home"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },);
                  }
                  catch(e){
                    ErrorHandle.showError("Something wrong");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimary,
                  fixedSize: Size(300.w, 40.h),
                ),
                child: Text(
                  "Confirm",
                  style: TextStyle(fontSize: 20.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final String image1;
  final String productName;
  final double productPrice;
  final int quantity;
  const OrderTile({Key key, this.image1, this.productName, this.productPrice, this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 290.w,
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: 80.w,
                height: 80.w,
                child: Image.network(image1,fit: BoxFit.fill,),
              ),
              SizedBox(
                width: 170.w,
                child: Column(
                  children: [
                    Text(productName),
                    SizedBox(height: 10.h,),
                    Text("₹ ${(productPrice*quantity).toString()}")
                  ],
                ),
              ),
              Text(quantity.toString())
            ],
          ),
        ),
      ),
    );
  }
}
