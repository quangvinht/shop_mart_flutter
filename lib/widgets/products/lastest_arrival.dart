import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop_mart/consts/app_constants.dart';
import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/providers/carts_provider.dart';
import 'package:shop_mart/providers/viewed_product_provider.dart';
import 'package:shop_mart/screens/inners/product_detail_screen.dart';
import 'package:shop_mart/widgets/products/heart_btn.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';

class LastestArrival extends ConsumerWidget {
  const LastestArrival({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    bool isProdcutIncart = ref
        .watch(cartsProvider.notifier)
        .isProductInCart(ref, product.productId);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          ref
              .read(ViewedProductProvider.notifier)
              .addProductViewedProduct(product);

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => ProductDetail(
                product: product,
              ),
            ),
          );
        },
        child: SizedBox(
          width: size.width * 0.5,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FancyShimmerImage(
                    imageUrl: product.productImage,
                    width: size.width * 0.24,
                    height: size.height * 0.32,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          child: Row(
                            children: [
                              HeartBtn(
                                product: product,
                              ),
                              IconButton(
                                onPressed: () {
                                  if (!isProdcutIncart) {
                                    ref
                                        .read(cartsProvider.notifier)
                                        .addProductCart(product);
                                  }
                                },
                                icon: Icon(
                                  isProdcutIncart
                                      ? Icons.check
                                      : Icons.add_shopping_cart_outlined,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const FittedBox(
                          child: SubtitleText(
                            title: "250.000 VNĐ",
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
