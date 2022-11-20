import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/cart/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
