import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';
import 'package:kitanda_app/app/src/pages/cart/controller/cart_controller.dart';
import 'package:kitanda_app/app/src/pages_routers/app_pages.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

// ignore: must_be_immutable
class ItemTile extends StatefulWidget {
  ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;
  ItemTile({
    Key? key,
    required this.item,
    required this.cartAnimationMethod,
  }) : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGk = GlobalKey();
  final UtilsService service = UtilsService();
  IconData tileIcon = Icons.add_shopping_cart;
  final cartController = Get.find<CartController>();

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);
    await Future.delayed(const Duration(milliseconds: 1600));
    setState(() => tileIcon = Icons.add_shopping_cart);
  }

  @override
  Widget build(BuildContext context) {
    //colocar aqui, mas se de errado mover para outro local

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(PageRoutes.productRouter, arguments: widget.item);
          },
          child: Card(
            elevation: 3,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Imagem
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      transitionOnUserGestures: true,
                      child: Image.network(
                        widget.item.imgUrl,
                        key: imageGk,
                      ),
                    ),
                  ),
                  //nome do Item
                  Text(
                    widget.item.itemName,
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
                        service.formatNumberCurrency(widget.item.price),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: CustomColor.customSwatchColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //Unidade de Medida
                      Text(
                        '/${widget.item.unit}',
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
        ),
        //precisa ficar abaixo do card para fazer a sobreposição dele
        //botão carrinho
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15.0),
            ),
            child: Material(
              child: InkWell(
                //colocar a global key aqui
                onTap: () {
                  switchIcon();
                  widget.cartAnimationMethod(imageGk);
                  cartController.addItemToCart(item: widget.item);
                },
                child: Ink(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                    color: CustomColor.customSwatchColor,
                  ),
                  child: Icon(
                    tileIcon,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
