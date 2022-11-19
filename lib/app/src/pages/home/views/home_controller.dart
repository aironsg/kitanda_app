import 'package:get/get.dart';
import 'package:kitanda_app/app/src/models/category_model.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';
import 'package:kitanda_app/app/src/pages/home/repository/home_repository.dart';
import 'package:kitanda_app/app/src/pages/home/result/home_result.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  HomeRepository homeRepository = HomeRepository();
  bool isCategoryLoading = false;
  bool isProductLoading = true;
  UtilsService utilsService = UtilsService();
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;
  RxString searchTitle = ''.obs;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];
  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;

    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }
    update();
  }

  void selectedCategory(CategoryModel category) {
    currentCategory = category;
    update();

    if (currentCategory!.items.isNotEmpty) return;
    getAllProducts();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategories();

    debounce(searchTitle, (_) {
      update();
    }, time: const Duration(milliseconds: 600));
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

  void loadingMoreProducts() {
    currentCategory!.pagination++;
    getAllProducts(canLoad: false);
  }

  Future<void> getAllProducts({bool canLoad = false}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);
    setLoading(false, isProduct: true);

    result.when(success: (data) {
      currentCategory!.items.addAll(data);
    }, error: (message) {
      utilsService.showToast(message: message, isError: true);
    });
  }
}
