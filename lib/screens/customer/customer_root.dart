import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/customer/customer_home.dart';
import 'package:eshop/screens/customer/shopping_cart.dart';
import 'package:eshop/screens/customer/wishlist.dart';
import 'package:eshop/utils/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../main.dart';
import 'customer_profile.dart';




class CustomerRoot extends StatefulWidget {

  @override
  _CustomerRootState createState() => _CustomerRootState();
}

class _CustomerRootState extends State<CustomerRoot> {
  PersistentTabController _controller;
  FirebaseMessaging messaging;
  @override
  void initState() {
    _controller = PersistentTabController();
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("customer");
    messaging.getToken().then((value)async{
      final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
      if(data.data()['notificationKey']!=value){
        await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
          'notificationKey':value
        });
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  PersistentTabView(
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
      navBarStyle: NavBarStyle.style9,
    );
  }
  List<Widget> _buildScreens() {
    return [
      CustomerHome(),
      WishList(),
      ShoppingCart(),
      CustomerProfile(),
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
        icon: Icon(Icons.favorite,size: 27.w,),
        title: "Favorites",
        inactiveColorPrimary: CupertinoColors.systemGrey,
        activeColorPrimary: Colors.green,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart,size: 27.w,),
        title: "Cart",
        inactiveColorPrimary: CupertinoColors.systemGrey,
        activeColorPrimary: Colors.orange,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.perm_identity,size: 27.w,),
        title: "Profile",
        inactiveColorPrimary: CupertinoColors.systemGrey,
        activeColorPrimary: Colors.red,
      ),
    ];
  }
}
