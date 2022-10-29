import 'package:get/get.dart';
import 'package:kitanda_app/app/src/constants/storage_keys.dart';
import 'package:kitanda_app/app/src/models/user_model.dart';
import 'package:kitanda_app/app/src/pages/auth/repository/auth_repository.dart';
import 'package:kitanda_app/app/src/pages/auth/result/auth_result.dart';
import 'package:kitanda_app/app/src/pages_routers/app_pages.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilService = UtilsService();
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  //controller para login
  Future<void> signIn({required String email, required String password}) async {
    //email e senha terá uma validação vinda do backend

    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(success: (user) {
      this.user = user;
      utilService.showToast(message: 'Olá ${user.name}\n Seja Bem-vindo!');
      saveTokenAndProceedToHome();
    }, error: (message) {
      utilService.showToast(message: message, isError: true);
    });
  }

  Future<void> validateToken() async {
    String? token = await utilService.getLocalData(key: Storagekeys.token);
    if (token == null) {
      Get.offNamed(PageRoutes.signInRouter);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(success: (user) {
      this.user = user;
      saveTokenAndProceedToHome();
    }, error: (message) {
      signOut();
    });
  }

  void saveTokenAndProceedToHome() {
    //salvar token
    utilService.saveLocalData(key: Storagekeys.token, data: user.token!);
    //navegar para a pagina home
    Get.offNamed(PageRoutes.homeRouter);
  }

  Future<void> signOut() async {
    user = UserModel();
    utilService.deleteLocalData(key: Storagekeys.token);
    Get.offNamed(PageRoutes.signInRouter);
  }
}
