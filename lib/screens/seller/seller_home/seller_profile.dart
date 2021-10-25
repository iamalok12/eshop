import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class SellerProfile extends StatefulWidget {
  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  List<String> imageList = [
    "https://thumbs.dreamstime.com/z/shop-building-colorful-isolated-white-33822015.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Tuck_Shop_in_Oxford.jpg/330px-Tuck_Shop_in_Oxford.jpg",
    "https://thumbs.dreamstime.com/z/shop-building-colorful-isolated-white-33822015.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Tuck_Shop_in_Oxford.jpg/330px-Tuck_Shop_in_Oxford.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200.h,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 5)
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: imageList
                        .map(
                          (e) => Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            height: 100,
                            width: 200,
                            margin: EdgeInsets.all(10.w),
                            child: Image.network(
                              e,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
