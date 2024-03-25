import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersModel with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String productTitle;
  final String userName;
  final String price;
  final String imageUrl;
  final String quantity;
  final String totalPrice;

  final Timestamp orderDate;

  OrdersModel(
      {required this.orderId,
      required this.userId,
      required this.productId,
      required this.productTitle,
      required this.userName,
      required this.price,
      required this.imageUrl,
      required this.totalPrice,
      required this.quantity,
      required this.orderDate});

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      orderId: map['id'] ?? '',
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
      productTitle: map['productTitle'] ?? '',
      userName: map['userName'] ?? '',
      price: map['price'].toString() ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity'].toString() ?? '',
      orderDate: map['orderDate'] ?? '',
      totalPrice: map['totalPrice'].toString() ?? '',
    );
  }
}
