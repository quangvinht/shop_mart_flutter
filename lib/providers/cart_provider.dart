import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_mart/models/cart_model.dart';
import 'package:shop_mart/providers/products_provider.dart';
import 'package:shop_mart/services/cart_service.dart';
import 'package:shop_mart/services/my_app_functions.dart';

import 'package:uuid/uuid.dart';

final auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartitems {
    return _cartItems;
  }

// local
  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(
          cartId: const Uuid().v4(), productId: productId, quantity: 1),
    );
    notifyListeners();
  }

  void updateQty({required String productId, required int qty}) {
    _cartItems.update(
      productId,
      (cartItem) => CartModel(
        cartId: cartItem.cartId,
        productId: productId,
        quantity: qty,
      ),
    );
    notifyListeners();
  }

  bool isProdinCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  double getTotal({required ProductsProvider productsProvider}) {
    double total = 0.0;

    _cartItems.forEach((key, value) {
      final getCurrProduct = productsProvider.findByProdId(value.productId);
      if (getCurrProduct == null) {
        total += 0;
      } else {
        total += double.parse(getCurrProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  int getQty() {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void removeOneItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  //firebase

  Future<void> fetchCart() async {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user == null) {
      _cartItems.clear();
      return;
    }
    try {
      List<CartModel> carts = await CartService.getCarts(user.uid);
      if (carts.isEmpty) {
        return;
      } else {
        _cartItems = {for (var cart in carts) cart.productId: cart};
      }
    } catch (e) {}
    notifyListeners();
  }

  Future<void> addProductToFirebase({
    required String productId,
    required int quantity,
    required BuildContext context,
  }) async {
    if (user == null) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: "Please login first",
        fct: () {},
      );
      return;
    }
    final uid = user?.uid;
    final cartId = const Uuid().v4();
    try {
      await CartService.addCarts(
        uid!,
        cartId,
        productId,
        quantity,
      );
      await fetchCart();
      Fluttertoast.showToast(msg: "Item has been added");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearFirebaseCart() async {
    try {
      clearLocalCart();

      await CartService.clearCart(user!.uid);
      await fetchCart();
      Fluttertoast.showToast(msg: "Cart has been cleared");
    } catch (e) {
      print('clearFirebaseCart : $e');
    }
    notifyListeners();
  }

  Future<void> removeOneItemFirebaseCart(
    String cartId,
    String productId,
    int quantity,
  ) async {
    try {
      removeOneItem(productId: productId);

      await CartService.removeOneItemCart(
          user!.uid, cartId, productId, quantity);
      await fetchCart();
      Fluttertoast.showToast(msg: "Cart has been removed");
    } catch (e) {
      print('removeOneItemFirebaseCart : $e');
    }
    notifyListeners();
  }

  Future<void> updateQtyFirebaseCart(
    String cartId,
    String productId,
    int quantity,
  ) async {
    try {
      updateQty(productId: productId, qty: quantity);
      await CartService.updateQtyCart(
        user!.uid,
        cartId,
        productId,
        quantity,
      );

      await fetchCart();
      Fluttertoast.showToast(msg: "Cart's quantity has been updated");
    } catch (e) {
      print('updateQtyFirebaseCart : $e');
    }
    notifyListeners();
  }
}
