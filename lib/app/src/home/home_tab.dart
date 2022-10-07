import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/auth/config/custom_color.dart';

import 'components/category.tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<String> categories = [
    'Frutas',
    'Verduras',
    'Grãos',
    'Carnes',
    'Temperos',
  ];

  String selectedCategory = 'Verduras';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 20.0),

            //Carrinho
            child: GestureDetector(
              onTap: () {
                //logica para carrinho
              },
              child: Badge(
                badgeContent: Text(
                  '2',
                  style: TextStyle(
                      fontSize: 12, color: CustomColor.customCategoryColor),
                ),
                badgeColor: CustomColor.customContrasctColor,
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomColor.customSwatchColor,
                ),
              ),
            ),
          )
        ],
        elevation: 0,

        //Titulo
        title: Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 30,
            ),
            children: [
              TextSpan(
                  text: 'Green',
                  style: TextStyle(color: CustomColor.customSwatchColor)),
              TextSpan(
                  text: 'Grocer',
                  style: TextStyle(color: CustomColor.customContrasctColor)),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          //Campo de Pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
            child: TextFormField(
              style: TextStyle(
                color: CustomColor.customSwatchColor,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquise aqui',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: CustomColor.customContrasctColor,
                  size: 21,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),

          //categorias
          Container(
            padding: const EdgeInsets.only(left: 25.0),
            height: 40,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return CategoryTile(
                    onPressed: () {
                      setState(() {
                        selectedCategory = categories[index];
                      });
                    }, //fim onde pressed
                    category: categories[index],
                    isSelected: categories[index] == selectedCategory,
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(width: 10.0),
                itemCount: categories.length),
          ),

          //grid
        ],
      ),
    );
  }
}
