import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_mart/consts/app_constants.dart';
import 'package:shop_mart/widgets/carts/button_quantity.dart';
import 'package:shop_mart/widgets/products/heart_btn.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';
import 'package:shop_mart/widgets/title_text.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> showQuantityDialog() async {
      // await showModalBottomSheet(
      //   showDragHandle: true,
      //   context: context,
      //   builder: (ctx) {
      //     return const ButtonQuantity();
      //   },
      // );
    }

    Size size = MediaQuery.of(context).size;
    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl: AppConstants.imageUrl,
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
                      child: TitleText(label: 'Shoe' * 10),
                    ),
                    const Row(
                      children: [
                        TitleText(label: 'Price :'),
                        SizedBox(width: 3),
                        SubtitleText(
                          title: '250.000 VNĐ',
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        TitleText(label: 'Qty :'),
                        SizedBox(width: 3),
                        SubtitleText(
                          title: '10',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
