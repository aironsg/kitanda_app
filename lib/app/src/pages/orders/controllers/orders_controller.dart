import 'package:get/get.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/pages/auth/controller/auth_controller.dart';
import 'package:kitanda_app/app/src/pages/orders/repository/orders_repository.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

import '../../../models/cart_item_model.dart';
import '../result/orders_result.dart';

class OrdersController extends GetxController {
  final authController = Get.find<AuthController>();
  final orderRepository = OrdersRepository();
  final utilService = UtilsService();
  bool isLoading = false;
  OrderModel order;

  OrdersController(this.order);

  setOrdersLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrdersItems() async {
    setOrdersLoading(true);
    OrdersResult<List<CartItemModel>> result =
        await orderRepository.getOrderItems(
      orderId: order.id,
      token: authController.user.token!,
    );
    setOrdersLoading(false);

    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (message) =>
          utilService.showToast(message: message, isError: true),
    );
  }
}
