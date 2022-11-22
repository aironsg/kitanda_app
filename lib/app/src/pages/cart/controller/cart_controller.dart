import 'package:get/get.dart';
import 'package:kitanda_app/app/src/models/cart_item_model.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';
import 'package:kitanda_app/app/src/pages/auth/controller/auth_controller.dart';
import 'package:kitanda_app/app/src/pages/cart/cart_result/cart_result.dart';
import 'package:kitanda_app/app/src/pages/cart/repository/cart_repository.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsService = UtilsService();
  List<CartItemModel> cartItem = [];

  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItem) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: ((data) {
        cartItem = data;
        update();
      }),
      error: (message) {
        utilsService.showToast(message: message, isError: true);
      },
    );
  }

  getItemCart({required ItemModel item}) {
    return cartItem.indexWhere((itemToList) => itemToList.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int intemIndex = getItemCart(item: item);
    if (intemIndex >= 0) {
      cartItem[intemIndex].quantity += quantity;
    } else {
      final CartResult<String> result = await cartRepository.addItemToCart(
          userId: authController.user.id!,
          productId: item.id,
          token: authController.user.token!,
          quantity: quantity);

      result.when(
        success: (cartItemId) {
          cartItem.add(
            CartItemModel(
              id: cartItemId,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          utilsService.showToast(message: message, isError: true);
        },
      );

      update();
    }
  }
}
