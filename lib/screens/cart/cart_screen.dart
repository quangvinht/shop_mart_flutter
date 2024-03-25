import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_mart/models/order_model.dart';
import 'package:shop_mart/providers/cart_provider.dart';
import 'package:shop_mart/providers/user_provider.dart';
import 'package:shop_mart/screens/cart/cart_widget.dart';
import 'package:shop_mart/screens/loading_manager.dart';
import 'package:shop_mart/services/assets_manager.dart';
import 'package:shop_mart/services/my_app_functions.dart';
import 'package:shop_mart/services/order_service.dart';
import 'package:shop_mart/widgets/empty_bag.dart';
import 'package:shop_mart/widgets/title_text.dart';
import 'package:uuid/uuid.dart';

import '../../providers/products_provider.dart';
import 'bottom_checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return cartProvider.getCartitems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your cart is empty",
              subtitle:
                  "Looks like your cart is empty add something and make me happy",
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            bottomSheet: CartBottomSheetWidget(
              onCreateOrder: () {
                placeOrder(
                    cartProvider: cartProvider,
                    productProvider: productProvider,
                    userProvider: userProvider);
              },
            ),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  AssetsManager.shoppingCart,
                ),
              ),
              title: TitlesTextWidget(
                  label: "Cart (${cartProvider.getCartitems.length})"),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppFunctions.showErrorOrWarningDialog(
                      isError: false,
                      context: context,
                      subtitle: "Clear cart?",
                      fct: () {
                        cartProvider.clearFirebaseCart();
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: LoadingManager(
              isLoading: _isLoading,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartProvider.getCartitems.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: cartProvider.getCartitems.values
                                  .toList()[index],
                              child: const CartWidget());
                        }),
                  ),
                  const SizedBox(
                    height: kBottomNavigationBarHeight + 10,
                  )
                ],
              ),
            ),
          );
  }

  Future<void> placeOrder({
    required CartProvider cartProvider,
    required ProductsProvider productProvider,
    required UserProvider userProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      setState(() {
        _isLoading = true;
      });
      cartProvider.getCartitems.forEach((key, value) async {
        final getCurrProduct = productProvider.findByProdId(value.productId);
        final orderId = const Uuid().v4();

        await OrderService.addOrder(OrdersModel(
            orderId: orderId,
            userId: uid,
            productId: value.productId,
            productTitle: getCurrProduct!.productTitle,
            userName: userProvider.getUserModel!.userName,
            price: (double.parse(getCurrProduct.productPrice) * value.quantity)
                .toString(),
            imageUrl: getCurrProduct.productImage,
            totalPrice:
                (cartProvider.getTotal(productsProvider: productProvider))
                    .toString(),
            quantity: value.quantity.toString(),
            orderDate: Timestamp.now()));
      });
      await cartProvider.clearFirebaseCart();
    } catch (e) {
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: e.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
