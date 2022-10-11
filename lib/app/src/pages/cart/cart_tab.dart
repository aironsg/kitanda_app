import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class CartTab extends StatelessWidget {
  CartTab({Key? key}) : super(key: key);

  final UtilsService utilsService = UtilsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Carrinho',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          //Lista de Itens
          const Expanded(child: const Placeholder()),
          SizedBox(
            height: 20,
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
