import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class ItemTile extends StatelessWidget {
  ItemModel item;
  ItemTile({Key? key, required this.item}) : super(key: key);
  final UtilsService service = UtilsService();

  @override
  Widget build(BuildContext context) {
    //colocar aqui, mas se de errado mover para outro local

    return Stack(
      children: [
        //Botão Carrinho

        Card(
          elevation: 3,
          shadowColor: Colors.grey.shade300,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Imagem
                Expanded(child: Image.asset(item.imgUrl)),
                //Nome do Item
                Text(
                  item.itemName,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: CustomColor.customContrasctColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Preço e unidade de medida
                Row(
                  children: [
                    //Preço
                    Text(
                      service.formatNumberCurrency(item.price),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: CustomColor.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //Unidade de Medida
                    Text(
                      '/${item.unit}',
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        //precisa ficar abaixo do card para fazer a sobreposição dele
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => print('cliquei'),
            child: Container(
              height: 40,
              width: 35,
              decoration: BoxDecoration(
                color: CustomColor.customSwatchColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15.0),
                ),
              ),
              child: const Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}