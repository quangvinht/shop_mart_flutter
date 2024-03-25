import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_mart/models/order_model.dart';

class OrderService {
  static Future<List<OrdersModel>> getOrders() async {
    final orderCol = FirebaseFirestore.instance.collection("order");
    final snapshot = await orderCol.get();

    List<OrdersModel> orders = snapshot.docs.map((doc) {
      print(doc.data());
      return OrdersModel.fromMap(doc.data());
    }).toList();

    return orders;
  }

  static Future<void> addOrder(OrdersModel order) async {
    await FirebaseFirestore.instance
        .collection("order")
        .doc(order.orderId)
        .set({
      'id': order.orderId,
      'userId': order.userId,
      'productId': order.productId,
      "productTitle": order.productTitle,
      'price': double.parse(order.price),
      'totalPrice': double.parse(order.totalPrice),
      'quantity': int.parse(order.quantity),
      'imageUrl': order.imageUrl,
      'userName': order.userName,
      'orderDate': Timestamp.now(),
    });
  }

  static Future<void> removeOneOrder(String orderId) async {
    final ordersCol = FirebaseFirestore.instance.collection("order");
    await ordersCol.doc(orderId).delete();

    Fluttertoast.showToast(msg: "Item has been remove");
  }
}
