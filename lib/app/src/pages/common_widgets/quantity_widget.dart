import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget(
      {Key? key,
      required this.primaryIcon,
      required this.secondIcon,
      required this.item})
      : super(key: key);
  //acrescentar no contrutor os 2 icons

  final IconData primaryIcon;
  final IconData secondIcon;
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
          Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  if (quantity == 0) {
                    quantity = 0;
                  } else {
                    quantity--;
                  }
                });
              },
              child: Ink(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.primaryIcon,
                  size: 25.0,
                ),
              ),
            ),
          ),
          //esta unidade de medida será mudada de acordo com item inserido
          Row(
            children: [
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.item.unit,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  quantity++;
                });
              },
              child: Ink(
                height: 30,
                decoration: BoxDecoration(
                  color: CustomColor.customSwatchColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.secondIcon,
                  size: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
