import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/loading.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/authentication/login_screen.dart';
import 'package:eshop/screens/customer/help_center.dart';
import 'package:eshop/screens/customer/my_orders.dart';
import 'package:eshop/utils/colorpallets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'choose_address.dart';

class CustomerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: _height * 0.35,
                width: double.maxFinite,
                color: kPrimary,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    CircleAvatar(
                      radius: 40.w,
                      child: Icon(
                        Icons.perm_identity,
                        size: 50.w,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    StreamBuilder(
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
                            child: Text("Unable to load page"),
                          );
                        } else {
                          return Text(
                            snap.data['name'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: kWhite,),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    StreamBuilder(
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
                            child: Text("Unable to load page"),
                          );
                        } else {
                          return Column(
                            children: [
                              Text(
                                snap.data['mobile'].toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(color: kWhite),
                              ),
                              Text(
                                MasterModel.auth.currentUser.email,
                                textAlign: TextAlign.left,
                                style: const TextStyle(color: kWhite),
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(10.w),
                  elevation: 10.h,
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          pushNewScreen(context, screen: MyOrders());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 5, right: 5, bottom: 4,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.shopping_bag,
                                    color: kPrimary,
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    'My Orders',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: kBlack,
                        thickness: 0.5,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: ChooseAddress(
                              isNextButtonVisible: false,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 5, right: 5, bottom: 4,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_city,
                                    color: kPrimary,
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    'My Address',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: kBlack,
                        thickness: 0.5,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          pushNewScreen(context, screen: HelpCenter());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 5, right: 5, bottom: 8,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.help_center,
                                    color: kPrimary,
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    'Help Centre',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  LoadingWidget.showLoading(context);
                  MasterModel.signOut().then((value) {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  }).onError((error, stackTrace) {
                    LoadingWidget.removeLoading(context);
                    ErrorHandle.showError("Something wrong");
                  });
                },
                style: ElevatedButton.styleFrom(primary: kPrimary),
                child: const Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
