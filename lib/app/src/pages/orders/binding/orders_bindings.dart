import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/orders/controllers/all_orders_controller.dart';

class OrdersBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AllOrdersController());
  }
}
