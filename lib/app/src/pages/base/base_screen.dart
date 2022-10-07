import 'package:flutter/material.dart';

import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages/home/home_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 249, 249),
      body: PageView(
        physics:
            const NeverScrollableScrollPhysics(), //responsavel por travar o scrool de toque na tela
        controller: pageController,
        children: [
          const HomeTab(),
          Container(color: Colors.blue),
          Container(color: Colors.yellow),
          Container(color: Colors.purple),
        ],
      ),

      //bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              pageController.jumpToPage(index);
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: CustomColor.customSwatchColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Carrinho'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: 'Pedidos'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ]),
    );
  }
}
