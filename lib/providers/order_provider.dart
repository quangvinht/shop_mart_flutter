import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_mart/models/order_model.dart';
import 'package:shop_mart/services/order_service.dart';

final auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

class OrderProvider with ChangeNotifier {
  List<OrdersModel> orders = [];
  List<OrdersModel> get getOrders => orders;

  //firebase:
  Future<void> fetchOrders() async {
    try {
      final orderFetched = await OrderService.getOrders();
      orders = orderFetched
          .where((OrdersModel order) => order.userId == user!.uid)
          .toList();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> removeOrderFirebase(String orderId) async {
    try {
      await OrderService.removeOneOrder(orderId);
      await fetchOrders();
      notifyListeners();
    } catch (e) {}
  }
}
