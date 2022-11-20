import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/auth/controller/auth_controller.dart';
import 'package:kitanda_app/app/src/pages/cart/repository/cart_repository.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();

  Future<void> getCartItems() async {
    await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );
  }
}
