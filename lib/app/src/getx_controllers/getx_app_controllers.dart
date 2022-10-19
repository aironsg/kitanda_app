import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/auth/controller/auth_controller.dart';

class GetxAppControllers {
  //Lista responsavel por fazer a injeção de depedencias na memoria

  Future<void> initService() async {
    Get.put(AuthController());
  }
}
