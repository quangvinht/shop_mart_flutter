import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'package:shop_mart/models/cart.dart';
import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/models/whislist.dart';
import 'package:uuid/uuid.dart';

class Whislistotifier extends StateNotifier<List<WhislistModel>> {
  Whislistotifier() : super([]);

  void addOrRemoveProductWhislist(ProductModel product) {
    if (state.any((wl) => wl.product.productId == product.productId)) {
      state = state
          .where(
              (WhislistModel wl) => wl.product.productId != product.productId)
          .toList();
    } else {
      state = [
        ...state,
        WhislistModel(product: product, id: const Uuid().v4())
      ];
    }
  }

  bool isProductInWhisList(WidgetRef ref, String productId) {
      List<WhislistModel> whislist = ref.watch(WhislistProvider);
    return whislist.any((wl) => wl.product.productId == productId);
  }

    void removeAllWhislist() {
    state = [];
  }
}

final WhislistProvider =
    StateNotifierProvider<Whislistotifier, List<WhislistModel>>((ref) {
  return Whislistotifier();
});
