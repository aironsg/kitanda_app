import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key, required this.item}) : super(key: key);
  final ItemModel item;
  final UtilsService service = UtilsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Column(
        children: [
          //Botão Voltar
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
          ),
          //Imagem
          Expanded(child: Image.asset(item.imgUrl)),
          //Descrição
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(22.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 20),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Titulo e Preço
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Titulo
                          Text(
                            item.itemName,
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: CustomColor.customContrasctColor,
                            ),
                          ),

                          //Preço e Unidade de Medida
                          Row(
                            children: [
                              //Preço
                              Text(
                                service.formatNumberCurrency(item.price),
                                style: TextStyle(
                                  color: CustomColor.customSwatchColor,
                                  fontSize: 24.0,
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
                          ),
                        ],
                      ),
                      //Botão de Quantidade
                      Card(
                          color: Colors.white,
                          child: Row(
                            children: const [
                              Text('botao'),
                              Text('texto'),
                              Text('botao'),
                            ],
                          ))
                    ],
                  ),
                  // const Divider(
                  //   thickness: 2,
                  // ),

                  //Descrição produto
                  Container(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 0),
                    height: 180,
                    child: ListView(
                      children: [
                        Text(
                          item.description,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),

                  //Botão de Adicionar ao Carrinho
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.customSwatchColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0))),
                      onPressed: () {
                        //aqui ficará a logica de adicionar ao carrinho
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          Text(
                            'Adicionar ao carrinho',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
