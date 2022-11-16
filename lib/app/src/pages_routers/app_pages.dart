import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/auth/views/sign_in_screen.dart';
import 'package:kitanda_app/app/src/pages/auth/views/sing_up_screen.dart';
import 'package:kitanda_app/app/src/pages/base/base_screen.dart';
import 'package:kitanda_app/app/src/pages/cart/cart_tab.dart';
import 'package:kitanda_app/app/src/pages/home/bindings/home_bindings.dart';
import 'package:kitanda_app/app/src/pages/orders/orders_tab.dart';
import 'package:kitanda_app/app/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    //SignIn
    GetPage(name: PageRoutes.signInRouter, page: (() => SignInScreen())),
    //Splash
    GetPage(name: PageRoutes.splashRouter, page: () => const SplashScreen()),
    //signUp
    GetPage(name: PageRoutes.signUpRouter, page: (() => SignUpScreen())),
    //Home
    GetPage(
        name: PageRoutes.homeRouter,
        bindings: [
          HomeBindings(),
        ], //responsavel pela injeção de depedencia na memoria
        page: () => const BaseScreen()),
    //Cart
    GetPage(
      name: PageRoutes.cartRouter,
      page: () => const CartTab(),
    ),
    //Orders

    GetPage(name: PageRoutes.orderRouter, page: () => const OrdersTab()),

    //GetAllCategorys
  ];
}

abstract class PageRoutes {
  static const String signInRouter = '/signin';
  static const String splashRouter = '/splash';
  static const String signUpRouter = '/signUp';
  static const String homeRouter = '/home';
  static const String cartRouter = '/cart';
  static const String orderRouter = '/orders';
}
