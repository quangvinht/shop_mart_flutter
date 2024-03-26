import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_mart/consts/firebase_error.dart';
import 'package:shop_mart/models/wishlist_model.dart';
import 'package:shop_mart/services/whislist_service.dart';

import 'package:uuid/uuid.dart';

final auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _wishlistItems = {};
  Map<String, WishlistModel> get getWishlists {
    return _wishlistItems;
  }

  //local :

  void addOrRemoveFromWishlist({required String productId}) {
    if (_wishlistItems.containsKey(productId)) {
      _wishlistItems.remove(productId);
    } else {
      _wishlistItems.putIfAbsent(
        productId,
        () =>
            WishlistModel(wishlistId: const Uuid().v4(), productId: productId),
      );
    }

    notifyListeners();
  }

  bool isProdinWishlist({required String productId}) {
    return _wishlistItems.containsKey(productId);
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }

  //firebase :

  Future<void> fetchWhislist() async {
    if (user == null) {
      _wishlistItems.clear();
      return;
    }
    try {
      List<WishlistModel> whislist =
          await WhislistService.getWhislist(user!.uid);

      if (whislist.isEmpty) {
        return;
      } else {
        _wishlistItems = {for (var whis in whislist) whis.productId: whis};
      }
    } catch (e) {}

    notifyListeners();
  }

  Future<void> addOrRemoveFromWishlistFirebase(String productId) async {
    try {
      if (isProdinWishlist(productId: productId)) {
        await WhislistService.removeWhis(user!.uid, productId);
        _wishlistItems.remove(productId);
      } else {
        final whislistId = const Uuid().v4();
        await WhislistService.addWhis(user!.uid,
            WishlistModel(productId: productId, wishlistId: whislistId));

        _wishlistItems.putIfAbsent(
          productId,
          () => WishlistModel(productId: productId, wishlistId: whislistId),
        );
      }
      await fetchWhislist();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }

    notifyListeners();
  }

  Future<void> clearWishlistFirebase() async {
    try {
      clearLocalWishlist();

      await WhislistService.clearWishList(user!.uid);
      await fetchWhislist();
      Fluttertoast.showToast(msg: "Whislist have been cleared");
    } catch (e) {
      print('clearWishlistFirebase : $e');
    }
    notifyListeners();
  }
}
