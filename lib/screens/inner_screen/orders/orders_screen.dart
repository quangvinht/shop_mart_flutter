import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_mart/providers/order_provider.dart';
import '../../../../widgets/empty_bag.dart';
import '../../../services/assets_manager.dart';
import '../../../widgets/title_text.dart';
import 'orders_widget.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({super.key});

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(
            label: 'Placed orders',
          ),
        ),
        body: orderProvider.getOrders.isEmpty
            ? EmptyBagWidget(
                imagePath: AssetsManager.orderBag,
                title: "No orders has been placed yet",
                subtitle: "",
                buttonText: "Shop now")
            : ListView.separated(
                itemCount: orderProvider.getOrders.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: OrdersWidgetFree(order: orderProvider.orders[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                      // thickness: 8,
                      // color: Colors.red,
                      );
                },
              ));
  }
}
