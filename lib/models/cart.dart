import 'package:shop_mart/models/product.dart';

class CartsModel {
  CartsModel({required this.id, required this.product, required this.quantity});

  final String id;
  final ProductModel product;
  final int quantity;
}
