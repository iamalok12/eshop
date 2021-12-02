import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String address;
  String image1;
  String image2;
  String productName;
  double productPrice;
  String productDescription;
  String seller;
  String customer;
  String productId;
  int quantity;
  String orderId;
  bool shipped;
  bool delivered;
  bool cancelledBySeller;
  bool cancelledByCustomer;
  DateTime orderTime;

  OrderModel(
      {this.address,
        this.image1,
        this.image2,
        this.orderId,
        this.productName,
        this.orderTime,
        this.productPrice,
        this.productDescription,
        this.seller,
        this.customer,
        this.productId,
        this.quantity,
        this.shipped,
        this.delivered,
        this.cancelledBySeller,
        this.cancelledByCustomer,});

  OrderModel.fromJson(Map<String, dynamic> json) {
    address = json['address'] as String;
    orderTime=(json['orderTime'] as Timestamp).toDate();
    image1 = json['image1'] as String;
    image2 = json['image2'] as String;
    productName = json['productName'] as String;
    productPrice = json['productPrice']as double;
    productDescription = json['productDescription'] as String;
    seller = json['seller'] as String;
    customer = json['customer'] as String;
    productId = json['productId'] as String;
    orderId = json['orderId'] as String;
    quantity = json['quantity'] as int;
    shipped = json['shipped'] as bool;
    delivered = json['delivered'] as bool;
    cancelledBySeller = json['cancelledBySeller'] as bool;
    cancelledByCustomer = json['cancelledByCustomer'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['image1'] = image1;
    data['orderTime'] = orderTime;
    data['image2'] = image2;
    data['productName'] = productName;
    data['productPrice'] = productPrice;
    data['productDescription'] = productDescription;
    data['seller'] = seller;
    data['customer'] = customer;
    data['productId'] = productId;
    data['orderId'] = orderId;
    data['quantity'] = quantity;
    data['shipped'] = shipped;
    data['delivered'] = delivered;
    data['cancelledBySeller'] = cancelledBySeller;
    data['cancelledByCustomer'] = cancelledByCustomer;
    return data;
  }
}
