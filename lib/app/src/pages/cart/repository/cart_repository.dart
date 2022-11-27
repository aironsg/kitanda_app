import 'package:kitanda_app/app/src/constants/endpoints.dart';
import 'package:kitanda_app/app/src/models/cart_item_model.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/pages/cart/cart_result/cart_result.dart';
import 'package:kitanda_app/app/src/services/http_magager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.getCartItem,
      method: HttpMethod.post,
      hearders: {'X-Parse-Session-Token': token},
      body: {'user': userId},
    );

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error('error ao recuperar items do carrinho');
    }
  }

  Future<bool> changeItemQuantity(
      {required String token,
      required String cartItemId,
      required int quantity}) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.changeItemCart,
        method: HttpMethod.post,
        hearders: {'X-Parse-Session-Token': token},
        body: {'cartItemId': cartItemId, 'quantity': quantity});

    return result.isEmpty;
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String productId,
    required String token,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.addItemToCart,
        method: HttpMethod.post,
        hearders: {
          'X-Parse-Session-Token': token
        },
        body: {
          'user': userId,
          'quantity': quantity,
          'productId': productId,
        });

    if (result['result'] != null) {
      return CartResult.success(result['result']['id']);
    } else {
      return CartResult.error('Não foi possivel ao adicionar item no carrinho');
    }
  }

  Future<CartResult<OrderModel>> checkout(
      {required String token, required double total}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.checkout,
      method: HttpMethod.post,
      hearders: {'X-Parse-Session-Token': token},
      body: {'total': total},
    );

    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);
      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Não foi possivel concluir o pedido');
    }
  }
}
