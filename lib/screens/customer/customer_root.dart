import 'package:eshop/screens/customer/customer_home.dart';
import 'package:eshop/screens/customer/shopping_cart.dart';
import 'package:eshop/screens/customer/wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'customer_profile.dart';




class CustomerRoot extends StatefulWidget {

  @override
  _CustomerRootState createState() => _CustomerRootState();
}

class _CustomerRootState extends State<CustomerRoot> {
  PersistentTabController _controller;
  @override
  void initState() {
    _controller = PersistentTabController();
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
