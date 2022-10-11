import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({Key? key, required this.item}) : super(key: key);
  //acrescentar no contrutor os 2 icons
  final ItemModel item;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 35,
      width: 105,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //Botão de decremento de quantidade
          _QuantityButton(
            icon: Icons.remove,
            color: Colors.grey.shade300,
            onPressed: () {
              //resposanvel por decrementar os itens
              setState(() {
                if (quantity == 0) {
                  quantity = 0;
                } else {
                  quantity--;
                }
              });
            },
          ),
          //Unidade de Medida
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '${quantity.toString()} ${widget.item.unit}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          //Botão de incremento de item
          _QuantityButton(
            icon: Icons.add,
            color: CustomColor.customSwatchColor,
            onPressed: () {
              setState(() {
                quantity++;
              });
            },
          ),
        ],
      ),
    );
  }
}

//Classe de uso Especifico APenas para este Widget
class _QuantityButton extends StatelessWidget {
  const _QuantityButton(
      {required this.icon, required this.color, required this.onPressed});

  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 25.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
