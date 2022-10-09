import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages/auth/sing_in_screen.dart';
import 'package:kitanda_app/app/src/pages/auth/sing_up_screen.dart';
import 'package:kitanda_app/app/src/pages/base/base_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kitanda App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //esse atributo altera as cores padrão do app
          primarySwatch: CustomColor.customSwatchColor,
          scaffoldBackgroundColor: Colors.grey.withAlpha(50)),
      home: const SingInScreen(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SingInScreen()),
        GetPage(name: '/cadastro', page: () => SingUpScreen()),
        GetPage(name: '/base', page: () => const BaseScreen()),
      ],
    );
  }
}
