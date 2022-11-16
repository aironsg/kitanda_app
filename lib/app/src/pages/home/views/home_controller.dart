import 'package:get/get.dart';
import 'package:kitanda_app/app/src/models/category_model.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';
import 'package:kitanda_app/app/src/pages/home/repository/home_repository.dart';
import 'package:kitanda_app/app/src/pages/home/result/home_result.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class HomeController extends GetxController {
  HomeRepository homeRepository = HomeRepository();
  bool isLoading = false;
  UtilsService utilsService = UtilsService();
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void selectedCategory(CategoryModel category) {
    currentCategory = category;
    update();
    getAllProducts();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    setLoading(true); //responsavel pelo carregamento
    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();
    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        if (allCategories.isEmpty) return;
        selectedCategory(allCategories.first);
      },
      error: (message) {
        utilsService.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> getAllProducts() async {
    setLoading(true);

    Map<String, dynamic> body = {
      "page": 0,
      "title": null,
      "categoryId": "5mjkt5ERRo",
      "itemsPerPage": 6
    };

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);
    setLoading(false);

    result.when(success: (data) {
      print(data);
    }, error: (message) {
      utilsService.showToast(message: message, isError: true);
    });
  }
}
