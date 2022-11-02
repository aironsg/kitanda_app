import 'package:get/get.dart';
import 'package:kitanda_app/app/src/models/category_model.dart';
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
}
