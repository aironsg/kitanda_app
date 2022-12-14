import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages_routers/app_pages.dart';

import 'app/src/getx_controllers/getx_app_controllers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //injeção de depedencias
  GetxAppControllers().initService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //responsavel por fechar teclado, quando clicado fora
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetMaterialApp(
        title: 'Kitanda App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //esse atributo altera as cores padrão do app
            primarySwatch: CustomColor.customSwatchColor,
            scaffoldBackgroundColor: Colors.grey.withAlpha(50)),
        initialRoute: PageRoutes.splashRouter,
        getPages: AppPages.pages,
      ),
    );
  }
}
