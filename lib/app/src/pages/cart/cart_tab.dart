import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/quantity_widget.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';
import 'package:kitanda_app/app/src/config/app_data.dart' as app_data;

class CartTab extends StatelessWidget {
  CartTab({Key? key}) : super(key: key);

  final UtilsService utilsService = UtilsService();
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
                return ItemCart(index: index);
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
                  utilsService.formatNumberCurrency(50.5),
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
                      onPressed: () {},
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
}

class ItemCart extends StatelessWidget {
  int index;
  final UtilsService utilsService = UtilsService();
  ItemCart({
    Key? key,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var valueTotalItem = app_data.cartItens[index].item.price *
        app_data.cartItens[index].quantity;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(app_data.cartItens[index].item.imgUrl),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //mecher ainda no visual
                      Text(
                        app_data.cartItens[index].item.itemName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      //valor total do produto escolhido
                      Text(
                        utilsService.formatNumberCurrency(valueTotalItem),
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.customSwatchColor),
                      ),
                    ],
                  ),
                ],
              ),
              QuantityWidget(
                item: app_data.cartItens[index].item,
                result: (index) {},
                quantity: app_data.cartItens[index].quantity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
