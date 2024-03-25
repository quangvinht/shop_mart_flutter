import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_mart/models/wishlist_model.dart';

class WhislistService {
  static Future<List<WishlistModel>> getWhislist(String userId) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    final snapshot = await usersCol.doc(userId).get();
    final userWhislist = snapshot.data()?['Wish'] as List<dynamic>? ?? [];
    List<WishlistModel> whislist = userWhislist.map((whisMap) {
      return WishlistModel.fromMap(Map<String, dynamic>.from(whisMap));
    }).toList();

    return whislist;
  }

  static Future<void> addWhis(String userId, WishlistModel whis) async {
    final usersCol = FirebaseFirestore.instance.collection("users");

    await usersCol.doc(userId).update({
      'Wish': FieldValue.arrayUnion([
        {
          'id': whis.wishlistId,
          'productId': whis.productId,
        }
      ])
    });
    Fluttertoast.showToast(msg: "Item has been added to whislist");
  }

  static Future<void> removeWhis(String userId, String productId) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    final snapshot = await usersCol.doc(userId).get();
    final userWhislist = snapshot.data()?['Wish'] as List<dynamic>? ?? [];

    final whisToRemove = userWhislist.firstWhere(
      (whis) => whis['productId'] == productId,
      orElse: () => null,
    );

    if (whisToRemove != null) {
      await usersCol.doc(userId).update({
        'Wish': FieldValue.arrayRemove([whisToRemove])
      });
    }
    Fluttertoast.showToast(msg: "Item has been remove");
  }

  static Future<void> clearWishList(
    String userId,
  ) async {
    final usersCol = FirebaseFirestore.instance.collection("users");
    await usersCol.doc(userId).update({'Wish': []});
  }
}
