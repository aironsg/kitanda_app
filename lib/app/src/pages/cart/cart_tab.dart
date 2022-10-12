import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/app_data.dart' as app_data;
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/cart_item_model.dart';
import 'package:kitanda_app/app/src/pages/cart/components/cart_tile.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsService utilsService = UtilsService();

  void removerItemCart(CartItemModel cartItem) {
    setState(() {
      app_data.cartItens.remove(cartItem);
    });
  }

  double cartTotalPrice() {
    double total = 0;

    for (var item in app_data.cartItens) {
      total += item.totalPrice();
    }

    return total;
  }

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
            child: ListView.builder(
              itemBuilder: (_, index) {
                return CartTile(
                  cartItem: app_data.cartItens[index],
                  remove: removerItemCart,
                );
              },
              itemCount: app_data.cartItens.length,
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
                Text(
                  utilsService.formatNumberCurrency(cartTotalPrice()),
                  style: TextStyle(
                    fontSize: 24,
                    color: CustomColor.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Botão comprar
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        bool? result = await showOrderConfirmation();
                        print(result);
                      },
                      child: const Text(
                        'Finalizar Compra',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )),
                )
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
