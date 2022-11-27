import 'package:get/get.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/pages/auth/controller/auth_controller.dart';
import 'package:kitanda_app/app/src/pages/orders/repository/orders_repository.dart';
import 'package:kitanda_app/app/src/pages/orders/result/orders_result.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class AllOrdersController extends GetxController {
  final orderRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilService = UtilsService();
  List<OrderModel> allOrders = [];

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await orderRepository.getAllOrders(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (orders) {
        allOrders = orders
          ..sort(
            (a, b) => b.createdDateTime!.compareTo(a.createdDateTime!),
          );
        update();
      },
      error: (message) =>
          utilService.showToast(message: message, isError: true),
    );

    update();
  }
}
