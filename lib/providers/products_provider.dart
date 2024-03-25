import 'package:flutter/material.dart';
import 'package:shop_mart/services/products_services.dart';

import '../models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> products = [];

  List<ProductModel> get getProducts {
    return products;
  }

  Future<void> fetchproducts() async {
    try {
      products = await ProductService.getProducts();
      notifyListeners();
    } catch (e) {}
  }

  void listenToProductsStream() {
    ProductService.getProductsStream().listen((productList) {
      products = productList;
      notifyListeners();
    });
  }

  Stream<List<ProductModel>> fetchProductsStream() {
    listenToProductsStream();
    return ProductService.getProductsStream();
  }

  ProductModel? findByProdId(String productId) {
    if (products.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    return products.firstWhere((element) => element.productId == productId);
  }

  List<ProductModel> findByCategory({required String categoryName}) {
    List<ProductModel> categoryList = products
        .where(
          (element) => element.productCategory.toLowerCase().contains(
                categoryName.toLowerCase(),
              ),
        )
        .toList();
    return categoryList;
  }

  List<ProductModel> searchQuery(
      {required String searchText, required List<ProductModel> passedList}) {
    List<ProductModel> searchList = passedList
        .where(
          (element) => element.productTitle.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return searchList;
  }
}
