import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/orders/components/order_tile.dart';

import '../controllers/all_orders_controller.dart';

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
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (_, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) =>
                  OrderTile(order: controller.allOrders[index]),
              itemCount: controller.allOrders.length,
            ),
          );
        },
      ),
    );
  }
}
