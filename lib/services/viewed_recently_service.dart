import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shop_mart/models/viewed_products.dart';

class ViewedService {
  static Future<List<ViewedProdModel>> getViewed(String userId) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    final snapshot = await usersCol.doc(userId).get();
    final userWhislist = snapshot.data()?['Viewed'] as List<dynamic>? ?? [];
    List<ViewedProdModel> whislist = userWhislist.map((whisMap) {
      return ViewedProdModel.fromMap(Map<String, dynamic>.from(whisMap));
    }).toList();

    return whislist;
  }

  static Future<void> addViewed(String userId, ViewedProdModel viewed) async {
    final usersCol = FirebaseFirestore.instance.collection("users");

    await usersCol.doc(userId).update({
      'Viewed': FieldValue.arrayUnion([
        {
          'id': viewed.viewedProdId,
          'productId': viewed.productId,
        }
      ])
    });
    //  Fluttertoast.showToast(msg: "Item has been added to Viewed product");
  }

  static Future<void> removeViewed(String userId, String productId) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    final snapshot = await usersCol.doc(userId).get();
    final userVieweds = snapshot.data()?['Viewed'] as List<dynamic>? ?? [];

    final viewedToRemove = userVieweds.firstWhere(
      (viewed) => viewed['productId'] == productId,
      orElse: () => null,
    );

    if (viewedToRemove != null) {
      await usersCol.doc(userId).update({
        'Viewed': FieldValue.arrayRemove([viewedToRemove])
      });
    }
    Fluttertoast.showToast(msg: "Item has been remove");
  }

  static Future<void> clearViewed(
    String userId,
  ) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    await usersCol.doc(userId).update({'Viewed': []});
  }
}
