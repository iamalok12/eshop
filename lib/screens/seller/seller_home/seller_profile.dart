import 'package:eshop/features/seller_profile/bloc/seller_profile_bloc.dart';
import 'package:eshop/features/seller_profile/domain/seller_profile_class.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/screens/authentication/seller_register3.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SellerProfile extends StatefulWidget {
  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  List<SellerProfileClass> list = [];
  List<String> imageList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SellerProfileBloc()..add(SellerProfileTrigger()),
          child: BlocConsumer<SellerProfileBloc, SellerProfileState>(
            builder: (context, state) {
              if (state is SellerProfileLoaded) {
                return Center(
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: kWhite,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220.h,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: imageList
                                        .map(
                                          (e) => Image.network(
                                            e,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (
                                              context,
                                              child,
                                              loadingProgress,
                                            ) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) =>
                                                const Text(
                                              'Some errors occurred!',
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      pushNewScreen(
                                        context,
                                        screen: SellerRegister3(),
                                        withNavBar: false,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: Colors.black54,
                                      size: 30.w,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 200.h),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: kWhite,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.w),
                            topLeft: Radius.circular(30.w),
                          ),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              list.first.shopName,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontFamily: "Orbitron",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              constraints: BoxConstraints(
                                minHeight: 40.h,
                              ),
                              width: 280.w,
                              decoration: BoxDecoration(
                                color: kPrimary,
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                              child: Center(
                                child: Text(
                                  "Shop owner:- ${list.first.sellerName}",
                                  style:
                                      TextStyle(color: kWhite, fontSize: 15.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            Container(
                              constraints: BoxConstraints(
                                minHeight: 40.h,
                              ),
                              width: 280.w,
                              decoration: BoxDecoration(
                                color: kPrimary,
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                              child: Center(
                                child: Text(
                                  "Validity:- ${list.first.validity.toDate().day}/${list.first.validity.toDate().month}/${list.first.validity.toDate().year}",
                                  style:
                                  TextStyle(color: kWhite, fontSize: 15.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            Container(
                              width: 280.w,
                              constraints: BoxConstraints(
                                minHeight: 100.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                              child: Center(child: Text("Shop address:- ${list.first.locality}, ${list.first.area}, ${list.first.city},\n Pin: ${list.first.picCode}",textAlign: TextAlign.center,),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is SellerProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Text(
                    "Unable to fetch data",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                );
              }
            },
            listener: (context, state) {
              if (state is SellerProfileLoaded) {
                setState(() {
                  list.clear();
                  imageList.clear();
                  list = state.list;
                  imageList.add(state.list.single.image1);
                  imageList.add(state.list.single.image2);
                  imageList.add(state.list.single.image3);
                  imageList.add(state.list.single.image4);
                });
              } else if (state is SellerProfileError) {
                ErrorHandle.showError("Something wrong");
              }
            },
          ),
        ),
      ),
    );
  }
}
