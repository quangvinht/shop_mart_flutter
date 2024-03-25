import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_mart/models/cart_model.dart';

class CartService {
  static Future<List<CartModel>> getCarts(String userId) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    final snapshot = await usersCol.doc(userId).get();
    final userCart = snapshot.data()?['Cart'] as List<dynamic>? ?? [];
    List<CartModel> carts = userCart.map((cartMap) {
      return CartModel.fromMap(Map<String, dynamic>.from(cartMap));
    }).toList();

    return carts;
  }

  static Future<void> addCarts(
    String userId,
    String cartId,
    String productId,
    int quantity,
  ) async {
    final usersCol = FirebaseFirestore.instance.collection("users");

    await usersCol.doc(userId).update({
      'Cart': FieldValue.arrayUnion([
        {
          'id': cartId,
          'productId': productId,
          'quantity': quantity,
        }
      ])
    });
  }

  static Future<void> clearCart(
    String userId,
  ) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    await usersCol.doc(userId).update({'Cart': []});
  }

  static Future<void> removeOneItemCart(
    String userId,
    String cartId,
    String productId,
    int quantity,
  ) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    await usersCol.doc(userId).update({
      'Cart': FieldValue.arrayRemove([
        {
          'id': cartId,
          'productId': productId,
          'quantity': quantity,
        }
      ])
    });
  }

  static Future<void> updateQtyCart(
    String userId,
    String cartId,
    String productId,
    int quantity,
  ) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    final snapshot = await usersCol.doc(userId).get();
    final userCart = snapshot.data()?['Cart'] as List<dynamic>? ?? [];
    int index = userCart.indexWhere((item) => item['id'] == cartId);
    userCart[index]['quantity'] = quantity;
    await usersCol.doc(userId).update({'Cart': userCart});
  }
}
