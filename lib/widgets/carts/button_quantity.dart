import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:shop_mart/providers/carts_provider.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';

class ButtonQuantity extends ConsumerStatefulWidget {
  const ButtonQuantity({super.key, required this.cartId});

  final String cartId;

  @override
  ConsumerState<ButtonQuantity> createState() => _ButtonQuantityState();
}

class _ButtonQuantityState extends ConsumerState<ButtonQuantity> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            print(index + 1);
            ref
                .read(cartsProvider.notifier)
                .changeQuantity(widget.cartId, index + 1);
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              child: Center(
                child: SubtitleText(
                  title: '${index + 1}',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
