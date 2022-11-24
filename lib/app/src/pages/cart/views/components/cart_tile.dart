import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/cart_item_model.dart';
import 'package:kitanda_app/app/src/pages/cart/controller/cart_controller.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/quantity_widget.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;

  const CartTile({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsService utilsService = UtilsService();

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ListTile(
        //Imagem
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),

        //Titulo
        title: Text(
          widget.cartItem.item.itemName,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColor.customContrasctColor),
        ),

        //Preço total
        subtitle: Text(
          utilsService.formatNumberCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
              fontSize: 18.0,
              color: CustomColor.customSwatchColor,
              fontWeight: FontWeight.bold),
        ),

        //widget de acrescentar e dimunir
        trailing: QuantityWidget(
          item: widget.cartItem.item,
          result: (quantity) {
            cartController.changeItemQuantity(
              item: widget.cartItem,
              quantity: quantity,
            );
          },
          quantity: widget.cartItem.quantity,
          isRemoveble: true,
        ),
      ),
    );
  }
}
