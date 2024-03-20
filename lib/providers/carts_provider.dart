import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'package:shop_mart/models/cart.dart';
import 'package:shop_mart/models/product.dart';
import 'package:uuid/uuid.dart';

class CartNotifier extends StateNotifier<List<CartsModel>> {
  CartNotifier() : super([]);

  void addProductCart(ProductModel product) {
    state = [
      ...state,
      CartsModel(product: product, quantity: 1, id: const Uuid().v4())
    ];
  }



  bool isProductInCart(WidgetRef ref, String productId) {
    List<CartsModel> carts = ref.watch(cartsProvider);
    return carts.any((cart) => cart.product.productId == productId);
  }

  void changeQuantity(String cartId, int quantity) {
    state = state.map((CartsModel cart) {
      if (cart.id == cartId) {
        return CartsModel(
            product: cart.product, quantity: quantity, id: cart.id);
      }
      return cart;
    }).toList();
  }

  double get totalPrice {
    return state.fold(
        0,
        (previous, current) =>
            previous +
            double.parse(current.product.productPrice) * current.quantity);
  }

  int get totalQuantity {
    var result =
        state.fold(0, (previous, current) => previous + current.quantity);

    return result;
  }

  void removeCart(String cartId) {
    state = state.where((CartsModel cart) => cart.id != cartId).toList();
  }

  void removeAllCart() {
    state = [];
  }
}

final cartsProvider =
    StateNotifierProvider<CartNotifier, List<CartsModel>>((ref) {
  return CartNotifier();
});
