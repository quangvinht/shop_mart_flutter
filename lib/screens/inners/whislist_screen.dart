import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/models/whislist.dart';
import 'package:shop_mart/providers/products_provider.dart';
import 'package:shop_mart/providers/whislist_provider.dart';
import 'package:shop_mart/services/app_function.dart';
import 'package:shop_mart/services/assets_manager.dart';
import 'package:shop_mart/widgets/app_name_text.dart';

import 'package:shop_mart/widgets/empty_bag.dart';
import 'package:shop_mart/widgets/products/product.dart';

import 'package:shop_mart/widgets/title_text.dart';

class WhislistScreen extends ConsumerStatefulWidget {
  const WhislistScreen({super.key});

  @override
  ConsumerState<WhislistScreen> createState() => _WhislistScreenState();
}

class _WhislistScreenState extends ConsumerState<WhislistScreen> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = ref.read(productsProvider.notifier).products;
    List<WhislistModel> whislist = ref.watch(WhislistProvider);

    if (whislist.isEmpty) {
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
            imagePath: AssetsManager.bagWish,
            subTitle: 'Look like your cart is empty. Let buy some thing ',
            btnText: 'Shopping...',
            title: 'Nothing in your whislist ...',
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
              MyAppFunctions.showErrorOrWarningDialog(
                  context: context,
                  subtitle: 'Clear whislist',
                  isError: false,
                  fct: () =>
                      ref.read(WhislistProvider.notifier).removeAllWhislist());
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          ),
        ],
        title: AppNameText(
          text: 'Whislist (${whislist.length})',
          fontSize: 20,
        ),
      ),
      body: DynamicHeightGridView(
          itemCount: whislist.length,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          builder: (ctx, index) {
            return Product(
              product: whislist[index].product,
            );
          }),
    );
  }
}
