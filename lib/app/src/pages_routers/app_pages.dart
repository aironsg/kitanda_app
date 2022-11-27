import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/auth/views/sign_in_screen.dart';
import 'package:kitanda_app/app/src/pages/auth/views/sing_up_screen.dart';
import 'package:kitanda_app/app/src/pages/base/base_screen.dart';
import 'package:kitanda_app/app/src/pages/base/binding/navigation_binding.dart';
import 'package:kitanda_app/app/src/pages/cart/binding/cart_binding.dart';
import 'package:kitanda_app/app/src/pages/cart/views/cart_tab.dart';
import 'package:kitanda_app/app/src/pages/home/bindings/home_bindings.dart';
import 'package:kitanda_app/app/src/pages/orders/binding/orders_bindings.dart';
import 'package:kitanda_app/app/src/pages/orders/views/orders_tab.dart';
import 'package:kitanda_app/app/src/pages/product/product_screen.dart';
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
      page: () => const BaseScreen(),
      name: PageRoutes.homeRouter,
      bindings: [
        NavigationBinding(),
        HomeBindings(),
        CartBinding(),
        OrdersBindings(),
      ],
    ),

    //Cart
    GetPage(
      name: PageRoutes.cartRouter,
      page: () => const CartTab(),
    ),

    //Orders
    GetPage(
      name: PageRoutes.orderRouter,
      page: () => const OrdersTab(),
    ),

    GetPage(name: PageRoutes.productRouter, page: () => ProductScreen()),
  ];
}

abstract class PageRoutes {
  static const String signInRouter = '/signin';
  static const String splashRouter = '/splash';
  static const String signUpRouter = '/signUp';
  static const String homeRouter = '/home';
  static const String cartRouter = '/cart';
  static const String orderRouter = '/orders';
  static const String productRouter = '/product';
}
