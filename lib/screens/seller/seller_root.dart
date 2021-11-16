// do not touch
import 'package:eshop/features/payment_status/bloc/payment_status_bloc.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/payment/payment_options.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/alert/progress_indicator.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SellerRoot extends StatefulWidget {
  @override
  State<SellerRoot> createState() => _SellerRootState();
}

class _SellerRootState extends State<SellerRoot> {

  PersistentTabController _controller;
  @override
  void initState() {
    _controller = PersistentTabController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getOfferStatus(context));
    super.initState();
  }

  Future<void> getOfferStatus(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider(
          create: (context) => PaymentStatusBloc()..add(PaymentStatusTrigger()),
          child: BlocConsumer<PaymentStatusBloc, PaymentStatusState>(
            builder: (context, state) {
              if (state is PaymentStatusLoading) {
                return Center(
                  child: LoadingIndicator(),
                );
              } else if (state is PaymentStatusError) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Center(
                      child: Text(
                        "Unable to fetch data",
                        style: TextStyle(fontSize: 20.sp, color: kWhite),
                      ),
                    ),
                  ),
                );
              } else if (state is PaymentStatusWithOffer) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Center(
                      child: Container(
                        color: kWhite,
                        height: 300.h,
                        width: 250.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 200.w,
                              width: 200.w,
                              child: Image.network(
                                state.imageAddress,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 40.h,
                              width: 240.w,
                              padding: EdgeInsets.only(
                                left: 5.w,
                                right: 2.w,
                                top: 2.w,
                                bottom: 2.w,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(state.coupon),
                                  IconButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: state.coupon),
                                      ).then((value) {
                                        ErrorHandle.showError("Copied");
                                      });
                                    },
                                    icon: const Icon(Icons.copy_outlined),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: SecondaryButton(
                                    label: "Logout",
                                    callback: () async {
                                      try {
                                        await MasterModel.signOut()
                                            .then((value) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        });
                                      } catch (e) {
                                        ErrorHandle.showError(
                                          "Something wrong",
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: PrimaryButton(
                                    label: "Pay",
                                    callback: () async {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentOptions(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Center(
                      child: Container(
                        color: kWhite,
                        height: 300.h,
                        width: 250.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 2.w,
                                left: 2.w,
                                right: 2.w,
                              ),
                              child: Text(
                                "Your plan has expired kindly, renew your plan.",
                                style: TextStyle(fontSize: 15.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 200.w,
                              width: 200.w,
                              child: Lottie.asset("assets/images/payment.json"),
                            ), //todo loading builder
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: SecondaryButton(
                                    label: "Logout",
                                    callback: () async {
                                      try {
                                        await MasterModel.signOut()
                                            .then((value) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        });
                                      } catch (e) {
                                        ErrorHandle.showError(
                                          "Something wrong",
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: PrimaryButton(
                                    label: "Pay",
                                    callback: () async {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentOptions(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
            listener: (context, state) {
              if (state is PaymentStatusAlreadyValid) {
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      resizeToAvoidBottomInset: true,
      decoration: NavBarDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
  List<Widget> _buildScreens() {
    return [
      SellerHome(),
      EditItems(),
      AddItem(),
      SellerProfile(),
      LogoutSeller()
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home,size: 27.w,),
        title: "Home",
        inactiveColorPrimary: CupertinoColors.systemGrey,
        activeColorPrimary: Colors.blue,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.edit_outlined,size: 27.w,),
        title: "Edit items",
        inactiveColorPrimary: CupertinoColors.systemGrey,
        activeColorPrimary: Colors.green,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.add,color:kWhite,),
        // title: "Add items",
        inactiveColorPrimary: Colors.black26,
        activeColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.perm_identity,size: 27.w,),
        title: "Profile",
        inactiveColorPrimary: CupertinoColors.systemGrey,
        activeColorPrimary: Colors.orange,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.logout,size: 27.w,),
        title: "Logout",
        inactiveColorPrimary: CupertinoColors.systemGrey,
        activeColorPrimary: Colors.red,
      ),
    ];
  }
}
