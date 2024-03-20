import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/models/cart.dart';
import 'package:shop_mart/providers/carts_provider.dart';
import 'package:shop_mart/services/app_function.dart';
import 'package:shop_mart/services/assets_manager.dart';
import 'package:shop_mart/widgets/app_name_text.dart';
import 'package:shop_mart/widgets/carts/bottom_checkout.dart';
import 'package:shop_mart/widgets/carts/cart.dart';
import 'package:shop_mart/widgets/empty_bag.dart';

import 'package:shop_mart/widgets/title_text.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<CartsModel> carts = ref.watch(cartsProvider);

    if (carts.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const TitleText(
            label: 'Cart',
            fontSize: 20,
          ),
        ),
        body: EmptyBag(
          imagePath: AssetsManager.shoppingBasket,
          subTitle: 'Look like your cart is empty. Let buy some thing ',
          btnText: 'Shopping...',
          title: 'No cart here...',
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        actions: [
          IconButton(
            onPressed: () {
              MyAppFunctions.showErrorOrWarningDialog(
                  context: context,
                  subtitle: 'Clear cart?',
                  isError: false,
                  fct: () => ref.read(cartsProvider.notifier).removeAllCart());
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          ),
        ],
        title: AppNameText(
          text: 'Cart (${carts.length})',
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 10),
        child: ListView.builder(
          itemCount: carts.length,
          itemBuilder: (ctx, index) {
            return Cart(
              cart: carts[index],
            );
          },
        ),
      ),
      bottomSheet: const CartBottomSheet(),
    );
  }
}
