import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/auth/repository/auth_repository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();

  //controller para login
  Future<void> signIn({required String email, required String password}) async {
    //email e senha terá uma validação vinda do backend

    isLoading.value = true;

    await authRepository.signIn(email: email, password: password);
    //await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
  }
}
