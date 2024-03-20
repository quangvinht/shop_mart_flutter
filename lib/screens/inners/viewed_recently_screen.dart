import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/models/viewed_product.dart';
import 'package:shop_mart/providers/products_provider.dart';
import 'package:shop_mart/providers/viewed_product_provider.dart';
import 'package:shop_mart/services/assets_manager.dart';
import 'package:shop_mart/widgets/app_name_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_mart/widgets/empty_bag.dart';
import 'package:shop_mart/widgets/products/product.dart';

import 'package:shop_mart/widgets/title_text.dart';

class ViewedRecentlyScreen extends ConsumerStatefulWidget {
  const ViewedRecentlyScreen({super.key});

  @override
  ConsumerState<ViewedRecentlyScreen> createState() =>
      _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends ConsumerState<ViewedRecentlyScreen> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    List<ViewedProductModel> viewProducts = ref.watch(ViewedProductProvider);

    if (viewProducts.isEmpty) {
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
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(IconlyLight.arrowLeft2)),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(ViewedProductProvider.notifier).removeAllViewedProduct();
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          ),
        ],
        title: AppNameText(
          text: 'Viewed recently (${viewProducts.length})',
          fontSize: 20,
        ),
      ),
      body: DynamicHeightGridView(
          itemCount: viewProducts.length,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          builder: (ctx, index) {
            return Product(
              product: viewProducts[index].product,
            );
          }),
    );
  }
}
