import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  //controller para login
  Future<void> sinIn({required String email, required String password}) async {
    //email e senha terá uma validação vinda do backend

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
  }
}
