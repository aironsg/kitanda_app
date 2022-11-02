import 'package:kitanda_app/app/src/constants/endpoints.dart';
import 'package:kitanda_app/app/src/models/category_model.dart';
import 'package:kitanda_app/app/src/pages/home/result/home_result.dart';
import 'package:kitanda_app/app/src/services/http_magager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: EndPoints.getAllCatogories,
      method: HttpMethod.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar as categorias');
    }
  }
}
