import 'package:kitanda_app/app/src/constants/endpoints.dart';
import 'package:kitanda_app/app/src/models/cart_item_model.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/pages/orders/result/orders_result.dart';
import 'package:kitanda_app/app/src/services/http_magager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<OrderModel>>> getAllOrders(
      {required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.getAllOrders,
        method: HttpMethod.post,
        hearders: {'X-Parse-Session-Token': token},
        body: {'user': userId});

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error('Não foi possivel recuperar os pedidos');
    }
  }

  Future<OrdersResult<List<CartItemModel>>> getOrderItems(
      {required String orderId, required String token}) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.getOrderItems,
        method: HttpMethod.post,
        hearders: {'X-Parse-Session-Token': token},
        body: {'orderId': orderId});

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return OrdersResult<List<CartItemModel>>.success(items);
    } else {
      return OrdersResult.error(
          'Não foi possivel recuperar os produto do pedidos');
    }
  }
}
