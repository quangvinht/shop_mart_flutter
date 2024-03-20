import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop_mart/consts/app_constants.dart';
import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/providers/carts_provider.dart';
import 'package:shop_mart/providers/products_provider.dart';
import 'package:shop_mart/providers/viewed_product_provider.dart';

import 'package:shop_mart/widgets/app_name_text.dart';
import 'package:shop_mart/widgets/products/heart_btn.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';
import 'package:shop_mart/widgets/title_text.dart';

class ProductDetail extends ConsumerStatefulWidget {
  const ProductDetail({super.key, required this.product});

  final ProductModel product;

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductModel? product = ref
        .read(productsProvider.notifier)
        .findProductById(widget.product.productId);

    bool isProdcutIncart = ref
        .watch(cartsProvider.notifier)
        .isProductInCart(ref, widget.product.productId);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // elevation: 0,
        leading: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const AppNameText(
          text: 'Shopping',
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: product != null
                  ? product.productImage
                  : AppConstants.imageUrl,
              width: double.infinity,
              height: size.height * 0.5,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      product != null ? product.productTitle : 'Title' * 15,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: SubtitleText(
                      title: product != null
                          ? "${product.productQuantity} VNĐ"
                          : "250.000 VNĐ",
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeartBtn(
                    bgColor: Colors.blue.shade100,
                    product: widget.product,
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: SizedBox(
                      height: kBottomNavigationBarHeight - 10,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          if (!isProdcutIncart) {
                            ref
                                .read(cartsProvider.notifier)
                                .addProductCart(widget.product);
                          }
                        },
                        icon: Icon(
                          isProdcutIncart
                              ? Icons.check
                              : Icons.add_shopping_cart_outlined,
                        ),
                        label:
                            Text(isProdcutIncart ? 'In cart' : 'Add to cart'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleText(
                    label: 'About this item',
                    fontSize: 26,
                  ),
                  SubtitleText(
                    title: product != null
                        ? 'In ${product.productCategory}'
                        : "In phones",
                  ),
                ],
              ),
            ),
            const SizedBox(width: 22),
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubtitleText(
                title: product != null
                    ? product.productDescription
                    : "Descriptiom" * 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
