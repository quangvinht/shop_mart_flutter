import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop_mart/models/cart.dart';
import 'package:shop_mart/providers/carts_provider.dart';
import 'package:shop_mart/widgets/carts/button_quantity.dart';
import 'package:shop_mart/widgets/products/heart_btn.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';
import 'package:shop_mart/widgets/title_text.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key, required this.cart});

  final CartsModel cart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> showQuantityDialog() async {
      await showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (ctx) {
          return ButtonQuantity(
            cartId: cart.id,
          );
        },
      );
    }

    Size size = MediaQuery.of(context).size;
    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl: cart.product.productImage,
                  height: size.height * 0.2,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.6,
                      child: TitleText(label: cart.product.productTitle),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubtitleText(
                          title: '${cart.product.productPrice} VNĐ',
                          color: Colors.blue,
                        ),
                        OutlinedButton.icon(
                          onPressed: showQuantityDialog,
                          icon: const Icon(IconlyLight.arrowDown2),
                          label: Text('Qty: ${cart.quantity}'),
                          // style: OutlinedButton.styleFrom(
                          //   side: const BorderSide(width: 1),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          // ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        ref.read(cartsProvider.notifier).removeCart(cart.id);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      )),
                   HeartBtn(product: cart.product,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
