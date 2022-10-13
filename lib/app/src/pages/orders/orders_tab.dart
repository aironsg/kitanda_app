import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/app_data.dart' as app_data;
import 'package:kitanda_app/app/src/pages/orders/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Pedidos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (context, index) =>
            OrderTile(order: app_data.orders[index]),
        itemCount: app_data.orders.length,
      ),
    );
  }
}
