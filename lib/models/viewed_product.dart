import 'package:shop_mart/models/product.dart';

class ViewedProductModel {
  ViewedProductModel({
    required this.id,
    required this.product,
  });

  final String id;
  final ProductModel product;
}
