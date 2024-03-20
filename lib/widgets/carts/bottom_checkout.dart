import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/models/cart.dart';
import 'package:shop_mart/providers/carts_provider.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';
import 'package:shop_mart/widgets/title_text.dart';

class CartBottomSheet extends ConsumerStatefulWidget {
  const CartBottomSheet({super.key});

  @override
  ConsumerState<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends ConsumerState<CartBottomSheet> {
  @override
  Widget build(BuildContext context) {
    List<CartsModel> carts = ref.watch(cartsProvider);

    int totalQuantity = ref.read(cartsProvider.notifier).totalQuantity;

    double totalPrice = ref.read(cartsProvider.notifier).totalPrice;

    return Container(
      width: double.infinity,
      height: kBottomNavigationBarHeight + 10,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      label:
                          'Total ( ${carts.length} produts / $totalQuantity items)',
                      fontSize: 16,
                    ),
                    SubtitleText(
                      title: '${totalPrice.toStringAsFixed(2)} VNĐ',
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
