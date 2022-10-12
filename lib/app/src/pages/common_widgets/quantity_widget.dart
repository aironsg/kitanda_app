import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    Key? key,
    required this.item,
    required this.result,
    required this.quantity,
    this.isRemoveble = false,
  }) : super(key: key);
  //acrescentar no contrutor os 2 icons
  final ItemModel item;
  final bool isRemoveble;
  final int quantity;
  final Function(int) result;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 35,
      width: 100,
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
          //esta unidade de medida será mudada de acordo com item inserido

          //Botão de Incremento
          _QuantityButton(
            icon: !isRemoveble || quantity > 1
                ? Icons.remove
                : Icons.delete_forever,
            color: !isRemoveble || quantity > 1
                ? Colors.grey.shade500
                : Colors.red,
            onPressed: () {
              if (quantity == 1 && !isRemoveble) return;
              var resultCount = quantity - 1;
              result(resultCount);
            },
          ),

          //Quantidade

          Text(
            '${quantity.toString()} ${item.unit}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
          ),

          //Botão de decremento
          _QuantityButton(
            icon: Icons.add,
            color: CustomColor.customSwatchColor,
            onPressed: () {
              var resultCount = quantity + 1;
              result(resultCount);
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
      {super.key,
      required this.icon,
      required this.color,
      required this.onPressed});

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
