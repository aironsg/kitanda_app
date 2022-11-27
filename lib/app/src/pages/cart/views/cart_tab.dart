import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages/cart/views/components/cart_tile.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

import '../controller/cart_controller.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsService utilsService = UtilsService();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Carrinho',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          //Lista de Itens
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                if (controller.cartItems.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 50,
                        color: CustomColor.customSwatchColor,
                      ),
                      const Text(
                        'Carrinho vazio!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  );
                }
                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) {
                    return CartTile(
                      cartItem: controller.cartItems[index],
                    );
                  },
                );
              },
            ),
          ),

          //Descrição
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color.fromARGB(255, 203, 207, 203),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(35.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Total
                const Text(
                  'Total geral',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                //Preço
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Text(
                      utilsService
                          .formatNumberCurrency(controller.cartTotalPrice()),
                      style: TextStyle(
                        fontSize: 24,
                        color: CustomColor.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                //Botão comprar
                SizedBox(
                  height: 50,
                  child: GetBuilder<CartController>(
                    builder: (controller) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: (controller.isCheckoutLoading ||
                                controller.cartItems.isEmpty)
                            ? null
                            : () async {
                                var result = await showOrderConfirmation();
                                if (result ?? false) {
                                  cartController.checkoutCart();
                                } else {
                                  utilsService.showToast(
                                      message: 'Pedido não confirmado');
                                }
                              },
                        child: controller.isCheckoutLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Finalizar Compra',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: const Text('Confirmação'),
          content: const Text('Deseja Realmente Confirmar o Pedido?'),
          actions: [
            //Botão cancelar
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Não')),

            //Botão confirmar
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Sim',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ))
          ],
        );
      },
    );
  }
}
