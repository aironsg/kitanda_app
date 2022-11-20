import 'package:kitanda_app/app/src/services/http_magager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future getCartItem() async {
    final result = await _httpManager.restRequest(
      url: url,
      method: method,
    );
  }
}
