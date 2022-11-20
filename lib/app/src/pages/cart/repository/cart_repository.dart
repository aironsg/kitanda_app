import 'package:kitanda_app/app/src/constants/endpoints.dart';
import 'package:kitanda_app/app/src/services/http_magager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future getCartItem({required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.getCartItem,
        method: HttpMethod.post,
        hearders: {'X-Parse-Session-Token': token},
        body: {'user': userId});

    if (result['result'] != null) {
      print(result['result']);
    } else {
      print('error ao recuperar items do carrinho');
    }
  }
}
