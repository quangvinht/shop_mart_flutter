import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/models/viewed_product.dart';

import 'package:uuid/uuid.dart';

class ViewedProducttotifier extends StateNotifier<List<ViewedProductModel>> {
  ViewedProducttotifier() : super([]);

  void addProductViewedProduct(ProductModel product) {
    if (!state.any(
        (ViewedProductModel vp) => vp.product.productId == product.productId)) {
      state = [
        ...state,
        ViewedProductModel(product: product, id: const Uuid().v4())
      ];
    }
  }

  void removeAllViewedProduct() {
    state = [];
  }
}

final ViewedProductProvider =
    StateNotifierProvider<ViewedProducttotifier, List<ViewedProductModel>>(
        (ref) {
  return ViewedProducttotifier();
});
