import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_mart/models/order_model.dart';
import 'package:shop_mart/providers/order_provider.dart';
import '../../../widgets/subtitle_text.dart';
import '../../../widgets/title_text.dart';

class OrdersWidgetFree extends StatefulWidget {
  const OrdersWidgetFree({super.key, required this.order});

  final OrdersModel order;
  @override
  State<OrdersWidgetFree> createState() => _OrdersWidgetFreeState();
}

class _OrdersWidgetFreeState extends State<OrdersWidgetFree> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              height: size.width * 0.25,
              width: size.width * 0.25,
              imageUrl: widget.order.imageUrl,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TitlesTextWidget(
                          label: widget.order.productTitle,
                          maxLines: 2,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await Provider.of<OrderProvider>(context,
                                    listen: false)
                                .removeOrderFirebase(widget.order.orderId);
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 22,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      // TitlesTextWidget(
                      //   label: 'Price: ${widget.order.price} ',
                      //   fontSize: 15,
                      // ),
                      Flexible(
                        child: SubtitleTextWidget(
                          label: "Price :${widget.order.totalPrice} \$",
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SubtitleTextWidget(
                    label: "Qty: ${widget.order.quantity}",
                    fontSize: 15,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
