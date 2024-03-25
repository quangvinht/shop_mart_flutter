
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_mart/models/product_model.dart';

class ProductService {
  static Future<List<ProductModel>> getProducts() async {
    final productsCol = FirebaseFirestore.instance.collection("products");
    final snapshot =
        await productsCol.orderBy('createdAt', descending: false).get();

    List<ProductModel> products = snapshot.docs.map((doc) {
      return ProductModel.fromMap(doc.data());
    }).toList();

    return products;
  }

  static Stream<List<ProductModel>> getProductsStream() {
    final productsCol = FirebaseFirestore.instance.collection("products");

    return productsCol.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data());
      }).toList();
    });
  }
}
