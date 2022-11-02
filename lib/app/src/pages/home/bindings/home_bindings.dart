import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/home/controller/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
