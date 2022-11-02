import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/config/app_data.dart' as app_data;
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages/cart/cart_tab.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/custom_shimmer.dart';
import 'package:kitanda_app/app/src/pages/home/views/components/item_tile.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

import '../common_widgets/app_name_widget.dart';
import 'views/components/category.tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';
  UtilsService utilsService = UtilsService();

  final GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

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
                Get.to(const CartTab());
              },
              child: Badge(
                badgeContent: Text(
                  //esta linha será alterado
                  '2',
                  style: TextStyle(
                      fontSize: 12, color: CustomColor.customCategoryColor),
                ),
                badgeColor: CustomColor.customContrasctColor,
                child: AddToCartIcon(
                  key: globalKeyCartItems,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: CustomColor.customSwatchColor,
                  ),
                ),
              ),
            ),
          )
        ],
        elevation: 0,

        //Titulo
        title: const AppNameWidget(),
      ),
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(microseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimation) {
          runAddToCardAnimation = addToCardAnimation;
        },
        child: Column(
          children: [
            //Campo de Pesquisa
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
              child: TextFormField(
                style: TextStyle(
                  color: CustomColor.customSwatchColor,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Pesquise aqui',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 14),
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
                child: !isLoading
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return CategoryTile(
                            onPressed: () {
                              setState(() {
                                selectedCategory = app_data.categories[index];
                              });
                            }, //fim onpressed
                            category: app_data.categories[index],
                            isSelected:
                                app_data.categories[index] == selectedCategory,
                          );
                        },
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 10.0),
                        itemCount: app_data.categories.length)
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          app_data.categories.length,
                          (index) => Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 10),
                            child: CustomShimmer(
                                borderRadius: BorderRadius.circular(10),
                                height: 20,
                                width: 60),
                          ),
                        ),
                      )),

            //grid

            Expanded(
              child: !isLoading
                  ? GridView.builder(
                      physics:
                          const BouncingScrollPhysics(), //responsavel por pausar o efeito de scroll
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5),
                      itemCount: app_data.items.length,
                      itemBuilder: (_, index) {
                        return ItemTile(
                          item: app_data.items[index],
                          cartAnimationMethod: itemSelectedCartAnimation,
                        );
                      },
                    )
                  : GridView.count(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                      children: List.generate(
                        app_data.items.length,
                        (index) => CustomShimmer(
                          borderRadius: BorderRadius.circular(20),
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
