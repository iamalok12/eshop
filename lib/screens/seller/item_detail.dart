import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productDescription;
  final String image1;
  final String image2;
  final String image3;
  final String image4;

  const ItemDetail({
    Key key,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.width,
            width: size.width,
            child: Card(
              elevation: 10.w,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [image1, image2, image3, image4]
                    .map(
                      (e) => Image.network(
                        e,
                        fit: BoxFit.fill,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.w),
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    productName,
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Divider(
                    thickness: 3.h,
                    color: kPrimary,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Price : ₹ $productPrice",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Description : $productDescription",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
