import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/customer/customer_root.dart';
import 'package:eshop/utils/colorpallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OrderPlace extends StatefulWidget {
  final String address;
  final String image1;
  final String image2;
  final String productName;
  final double productPrice;
  final String productDescription;
  final String seller;
  final String productID;
  const OrderPlace({
    Key key,
    this.address,
    this.image1,
    this.image2,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.seller,
    this.productID,
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
                height: 30.h,
              ),
              Text(
                "Confirm Order",
                style: TextStyle(fontSize: 30.sp, color: Colors.green),
              ),
              SizedBox(
                height: 100.h,
              ),
              Card(
                elevation: 50,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  height: 200.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 80.w,
                              width: 80.w,
                              child: Image.network(
                                widget.image1,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "${widget.productName}      x1",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total: ${widget.productPrice}",
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.black54,),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Shipping address:\n ${widget.address}",
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.black54,),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("Items")
                      .doc(widget.productID)
                      .get()
                      .then((value) async {
                    if (value.data()['isAvailable'] == true) {
                      await FirebaseFirestore.instance
                          .collection("orders")
                          .doc()
                          .set({
                        "address": widget.address,
                        "image1": widget.image1,
                        "image2": widget.image2,
                        "productName": widget.productName,
                        "productPrice": widget.productPrice,
                        "productDescription": widget.productDescription,
                        "seller": widget.seller,
                        "customer": MasterModel.auth.currentUser.email,
                        "productId": widget.productID,
                        "quantity":1,
                        "shipped":false,
                        "delivered":false
                      }).then((value) {
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
                      });
                    } else {
                      ErrorHandle.showError("Out of stock");
                    }
                  });
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
