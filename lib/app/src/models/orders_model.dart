import 'package:kitanda_app/app/src/models/cart_item_model.dart';

class OrdersModel {
  final String id;
  final DateTime createdDateTime;
  final DateTime overdueDateTime;
  final List<CartItemModel> items;
  final String status;
  final String copyAndPaste;
  final double total;

  OrdersModel({
    required this.id,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
  });

  double cartTotalPrice(List<CartItemModel> items) {
    double total = 0;

    for (var item in items) {
      total += item.totalPrice();
    }

    return total;
  }
}
