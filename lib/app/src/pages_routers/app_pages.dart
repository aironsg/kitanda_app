import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/auth/views/sign_in_screen.dart';
import 'package:kitanda_app/app/src/pages/auth/views/sing_up_screen.dart';
import 'package:kitanda_app/app/src/pages/base/base_screen.dart';
import 'package:kitanda_app/app/src/pages/cart/cart_tab.dart';
import 'package:kitanda_app/app/src/pages/orders/orders_tab.dart';
import 'package:kitanda_app/app/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: PageRoutes.signInRouter, page: (() => SignInScreen())),
    GetPage(name: PageRoutes.splashRouter, page: () => const SplashScreen()),
    GetPage(name: PageRoutes.signUpRouter, page: (() => SignUpScreen())),
    GetPage(name: PageRoutes.homeRouter, page: () => const BaseScreen()),
    GetPage(name: PageRoutes.cartRouter, page: () => const CartTab()),
    GetPage(name: PageRoutes.orderRouter, page: () => const OrdersTab())
  ];
}

abstract class PageRoutes {
  static const String signInRouter = '/signgn';
  static const String splashRouter = '/splash';
  static const String signUpRouter = '/signUp';
  static const String homeRouter = '/home';
  static const String cartRouter = '/cart';
  static const String orderRouter = '/orders';
}
