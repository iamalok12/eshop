import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/shop_category/bloc/shop_category_bloc.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerRegister1 extends StatefulWidget {
  @override
  State<SellerRegister1> createState() => _SellerRegister1State();
}

class _SellerRegister1State extends State<SellerRegister1> {
  List<String> shopCategories = [];
  final sellerName = TextEditingController();
  final shopName = TextEditingController();
  final mobileNumber = TextEditingController();
  String shopType = "Category";
  final _formKey = GlobalKey<FormState>();
  FirebaseMessaging messaging;

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    super.initState();
  }
  @override
  void dispose() {
    sellerName.dispose();
    shopName.dispose();
    mobileNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Sign up",
                    style: kPageHeading,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  PrimaryTextField(
                    controller: sellerName,
                    label: "Seller name",
                    keyboardType: TextInputType.name,
                    textFieldOptions: PrimaryTextFieldOptions.name,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  PrimaryTextField(
                    controller: mobileNumber,
                    label: "Seller mobile",
                    keyboardType: TextInputType.number,
                    textFieldOptions: PrimaryTextFieldOptions.mobile,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  PrimaryTextField(
                    controller: shopName,
                    label: "Shop name",
                    keyboardType: TextInputType.streetAddress,
                    textFieldOptions: PrimaryTextFieldOptions.name,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(2.w),
                    width: 260.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.w),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: BlocProvider(
                      create: (context) =>
                          ShopCategoryBloc()..add(ShopCategoryInitial()),
                      child: BlocConsumer<ShopCategoryBloc, ShopCategoryState>(
                        listener: (context, state) {
                          if (state is ShopCategoryLoaded) {
                            setState(() {
                              shopCategories.clear();
                              shopCategories = state.list;
                            });
                          } else if (state is ShopCategoryError) {
                            ErrorHandle.showError("Something wrong");
                          }
                        },
                        builder: (context, state) {
                          if (state is ShopCategoryLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ShopCategoryLoaded) {
                            return DropdownButton<String>(
                              isExpanded: true,
                              iconSize: 30.w,
                              hint: Text("  $shopType"),
                              underline: const Text(""),
                              items: shopCategories.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  shopType = value;
                                });
                              },
                            );
                          } else {
                            return const Center(
                              child: Text("Unable to fetch data"),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 160.h,
                  ),
                  PrimaryButton(
                    label: "Next",
                    callback: () async {
                      if (_formKey.currentState.validate() &&
                          shopType != "Category") {
                        try {
                          LoadingWidget.showLoading(context);
                          final Map<String,dynamic> map={};
                          messaging.getToken().then((value)async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(MasterModel.auth.currentUser.email)
                                .set({
                              "name": sellerName.text.trim(),
                              "shopName": sellerName.text.trim(),
                              "mobile": mobileNumber.text.trim(),
                              "category": shopType,
                              "notificationKey":value,
                              "isNotificationSeen":true,
                              "notification":map
                            }).then((value) {
                              LoadingWidget.removeLoading(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SellerRegister2(),
                                ),
                              );
                            });
                          });
                        } catch (e) {
                          ErrorHandle.showError("Something wrong");
                        }
                      } else {
                        ErrorHandle.showError("Please choose category");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
