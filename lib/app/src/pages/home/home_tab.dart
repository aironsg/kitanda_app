import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages/base/controller/navigation_controller.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/custom_shimmer.dart';
import 'package:kitanda_app/app/src/pages/home/views/components/item_tile.dart';
import 'package:kitanda_app/app/src/pages/home/views/home_controller.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

import '../cart/controller/cart_controller.dart';
import '../common_widgets/app_name_widget.dart';
import 'views/components/category.tile.dart';

// ignore: must_be_immutable
class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  UtilsService utilsService = UtilsService();
  final navigationController = Get.find<NavigationController>();
  final searchController = TextEditingController();

  final GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
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
            child: GetBuilder<CartController>(
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    navigationController
                        .navigationPageView(NavigationTabs.cart);
                  },
                  child: Badge(
                    badgeContent: Text(
                      //esta linha ser?? alterado
                      controller.cartItems.length.toString(),

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
                );
              },
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
            GetBuilder<HomeController>(
              init: HomeController(),
              initState: (controller) {},
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 20.0),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      controller.searchTitle.value = value;
                    },
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
                      suffixIcon: controller.searchTitle.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                controller.searchTitle.value = '';
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: CustomColor.customContrasctColor,
                                size: 21,
                              ),
                            )
                          : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                );
              },
            ),

            //categorias
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  padding: const EdgeInsets.only(left: 25.0),
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return CategoryTile(
                              onPressed: () {
                                controller.selectedCategory(
                                    controller.allCategories[index]);
                              },
                              category: controller.allCategories[index].title,
                              isSelected: controller.allCategories[index] ==
                                  controller.currentCategory,
                            );
                          },
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10.0),
                          itemCount: controller.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            controller.allCategories.length,
                            (index) => Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10),
                              child: CustomShimmer(
                                  borderRadius: BorderRadius.circular(10),
                                  height: 20,
                                  width: 60),
                            ),
                          ),
                        ),
                );
              },
            ),

            //grid

            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isProductLoading
                      ? Visibility(
                          visible: (controller.currentCategory?.items ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 50,
                                color: CustomColor.customSwatchColor,
                              ),
                              const Text('Nenhum Item para apresentar'),
                            ],
                          ),
                          child: GridView.builder(
                            physics:
                                const BouncingScrollPhysics(), //responsavel por pausar o efeito de scroll
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 9 / 11.5),
                            itemCount: controller.allProducts.length,
                            itemBuilder: (_, index) {
                              if (((index + 1) ==
                                      controller.allProducts.length) &&
                                  !controller.isLastPage) {
                                controller.loadingMoreProducts();
                              }

                              return ItemTile(
                                item: controller.allProducts[index],
                                cartAnimationMethod: itemSelectedCartAnimation,
                              );
                            },
                          ),
                        )
                      : GridView.count(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                            controller.allProducts.length,
                            (index) => CustomShimmer(
                              borderRadius: BorderRadius.circular(20),
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
