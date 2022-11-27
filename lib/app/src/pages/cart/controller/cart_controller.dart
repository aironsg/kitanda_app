import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/models/cart_item_model.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/pages/auth/controller/auth_controller.dart';
import 'package:kitanda_app/app/src/pages/cart/cart_result/cart_result.dart';
import 'package:kitanda_app/app/src/pages/cart/repository/cart_repository.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

import '../../common_widgets/payment_dialog.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsService = UtilsService();
  List<CartItemModel> cartItems = [];

  bool isCheckoutLoading = false;

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<bool> changeItemQuantity(
      {required CartItemModel item, required int quantity}) async {
    final result = await cartRepository.changeItemQuantity(
      token: authController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }
    } else {
      utilsService.showToast(
        message: 'Não foi possivel modificar item do carrinho',
        isError: true,
      );
    }

    update();

    return result;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: ((data) {
        cartItems = data;
        update();
      }),
      error: (message) {
        utilsService.showToast(message: message, isError: true);
      },
    );
  }

  getItemIndex({required ItemModel item}) {
    return cartItems.indexWhere((itemToList) => itemToList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int intemIndex = getItemIndex(item: item);
    if (intemIndex >= 0) {
      final product = cartItems[intemIndex];
      await changeItemQuantity(
          item: product, quantity: (quantity + product.quantity));
    } else {
      final CartResult<String> result = await cartRepository.addItemToCart(
          userId: authController.user.id!,
          productId: item.id,
          token: authController.user.token!,
          quantity: quantity);

      result.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(
              id: cartItemId,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          utilsService.showToast(
            message: message,
            isError: true,
          );
        },
      );
    }
    update();
  }

  void setCheckoutIsLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

  Future checkoutCart() async {
    CartResult<OrderModel> result = await cartRepository.checkout(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );

    setCheckoutIsLoading(true);

    result.when(
      success: (order) {
        cartItems.clear();
        update();
        showDialog(
          context: Get.context!,
          builder: (_) {
            return PaymentDialog(order: order);
          },
        );
      },
      error: (message) {
        utilsService.showToast(message: message);
      },
    );

    setCheckoutIsLoading(false);
  }
}
