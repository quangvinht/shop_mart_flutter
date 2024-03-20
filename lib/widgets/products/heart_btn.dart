import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/providers/whislist_provider.dart';

class HeartBtn extends ConsumerStatefulWidget {
  const HeartBtn({
    super.key,
    this.bgColor = Colors.transparent,
    this.size = 20,
    required this.product,
  });

  final Color bgColor;
  final double size;
  final ProductModel product;

  @override
  _HeartBtnState createState() => _HeartBtnState();
}

class _HeartBtnState extends ConsumerState<HeartBtn> {
  @override
  Widget build(BuildContext context) {
    bool isProductInWhisList = ref
        .read(WhislistProvider.notifier)
        .isProductInWhisList(ref, widget.product.productId);

    return Container(
      decoration: BoxDecoration(
        color: widget.bgColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
          style: IconButton.styleFrom(
            elevation: 10,
          ),
          onPressed: () {
            ref
                .read(WhislistProvider.notifier)
                .addOrRemoveProductWhislist(widget.product);
          },
          icon: Icon(
            size: widget.size,
            IconlyLight.heart,
            color: isProductInWhisList ? Colors.red : Colors.white,
          )),
    );
  }
}
