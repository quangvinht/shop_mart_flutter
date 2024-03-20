import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/providers/carts_provider.dart';
import 'package:shop_mart/providers/viewed_product_provider.dart';
import 'package:shop_mart/screens/inners/product_detail_screen.dart';
import 'package:shop_mart/widgets/products/heart_btn.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';
import 'package:shop_mart/widgets/title_text.dart';

class Product extends ConsumerStatefulWidget {
  const Product({super.key, required this.product});

  final ProductModel product;

  @override
  ConsumerState<Product> createState() => _ProductState();
}

class _ProductState extends ConsumerState<Product> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isProdcutIncart = ref
        .watch(cartsProvider.notifier)
        .isProductInCart(ref, widget.product.productId);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          ref
              .read(ViewedProductProvider.notifier)
              .addProductViewedProduct(widget.product);

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => ProductDetail(
                product: widget.product,
              ),
            ),
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FancyShimmerImage(
                imageUrl: widget.product.productImage,
                width: double.infinity,
                height: size.height * 0.22,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: TitleText(
                    label: widget.product.productTitle,
                    fontSize: 20,
                  ),
                ),
                HeartBtn(
                  product: widget.product,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: SubtitleText(
                    title: "${widget.product.productPrice} VNĐ",
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.lightBlue,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      if (!isProdcutIncart) {
                        ref
                            .read(cartsProvider.notifier)
                            .addProductCart(widget.product);
                      }
                    },
                    highlightColor: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: IconButton(
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
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
