import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_mart/services/viewed_recently_service.dart';

import 'package:uuid/uuid.dart';

import '../models/viewed_products.dart';

final auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

class ViewedProdProvider with ChangeNotifier {
  Map<String, ViewedProdModel> _viewedProdItems = {};

  Map<String, ViewedProdModel> get getViewedProds {
    return _viewedProdItems;
  }

  // local :

  bool isProdinViewed({required String productId}) {
    return _viewedProdItems.containsKey(productId);
  }

  void addViewedProd({required String productId}) {
    _viewedProdItems.putIfAbsent(
      productId,
      () => ViewedProdModel(
          viewedProdId: const Uuid().v4(), productId: productId),
    );

    notifyListeners();
  }

  void clearLocalViewedList() {
    _viewedProdItems.clear();
    notifyListeners();
  }

  //firebase:

  Future<void> fetchViewed() async {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user == null) {
      _viewedProdItems.clear();
      return;
    }
    try {
      List<ViewedProdModel> viewedList =
          await ViewedService.getViewed(user.uid);
      if (viewedList.isEmpty) {
        return;
      } else {
        _viewedProdItems = {
          for (var viewed in viewedList) viewed.productId: viewed
        };
      }
    } catch (e) {}
    notifyListeners();
  }

  Future<void> addViewedProdFirebase(String productId) async {
    final viewedId = const Uuid().v4();
    try {
      if (!isProdinViewed(productId: productId)) {
        addViewedProd(productId: productId);
        await ViewedService.addViewed(user!.uid,
            ViewedProdModel(viewedProdId: viewedId, productId: productId));
        await fetchViewed();
      }

      Fluttertoast.showToast(msg: "Item has been added");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLocalViewedListFirebase() async {
    try {
      clearLocalViewedList();

      await ViewedService.clearViewed(user!.uid);
      await fetchViewed();
      Fluttertoast.showToast(msg: "Viewed have been cleared");
    } catch (e) {
      print('clearWishlistFirebase : $e');
    }
    notifyListeners();
  }
}
