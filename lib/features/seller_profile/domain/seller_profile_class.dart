import 'package:cloud_firestore/cloud_firestore.dart';

class SellerProfileClass{
  final String sellerName;
  final String shopName;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String area;
  final String locality;
  final String picCode;
  final String city;
  final Timestamp validity;
  SellerProfileClass({this.sellerName, this.shopName, this.image1, this.image2, this.image3, this.image4, this.area, this.locality, this.picCode, this.city, this.validity});

}
