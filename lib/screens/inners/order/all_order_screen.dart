import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_mart/services/assets_manager.dart';
import 'package:shop_mart/widgets/app_name_text.dart';
import 'package:shop_mart/widgets/carts/cart.dart';

import 'package:shop_mart/widgets/empty_bag.dart';
import 'package:shop_mart/widgets/orders/order.dart';
import 'package:shop_mart/widgets/products/product.dart';

import 'package:shop_mart/widgets/title_text.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const TitleText(
            label: 'Cart',
            fontSize: 20,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: EmptyBag(
            imagePath: AssetsManager.shoppingBasket,
            subTitle: 'Look like your cart is empty. Let buy some thing ',
            btnText: 'Shopping...',
            title: 'No viewed products yet ...',
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(IconlyLight.arrowLeft2)),
        ),
        title: const AppNameText(
          text: 'Placed orders',
          fontSize: 20,
        ),
      ),
      body: ListView.separated(
        itemCount: 120,
        itemBuilder: (ctx, index) {
          return const Order();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
