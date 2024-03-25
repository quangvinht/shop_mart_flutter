import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String cartId;
  final String productId;
  final int quantity;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.quantity,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['id'] ?? '',
      productId: map['productId'] ?? '',
      quantity: map['quantity'] as int? ?? 0,
    );
  }
}
