//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/controlers/popular_product_controller.dart';
import 'package:foody/controlers/recomended_product_controller.dart';
import 'package:foody/pages/cart/cart_page.dart';
import 'package:foody/pages/food/app_icon.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:get/get.dart';
//import 'package:flutter/src/widgets/constants.dart';

import '../../controlers/cart_controller.dart';
import '../../routes/routes_helper.dart';
import '../home/main_food_page.dart';
import 'expandable_text_widget.dart';

class RecommendeFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendeFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 50,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (page == 'cartpage') {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.initial);
                        }
                      },
                      child: AppIcon(icon: Icons.clear),
                    ),
                    GetBuilder<PopularProductController>(builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.totalItems >= 1)
                            Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            controller.totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: Dimensions.height20,
                                      iconColor: Colors.transparent,
                                      backgroungColor: AppColors.mainColor,
                                    ),
                                  )
                                : Container(),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: Dimensions.height7,
                                    top: Dimensions.size3,
                                    child: BigText(
                                        text:
                                            Get.find<PopularProductController>()
                                                .totalItems
                                                .toString(),
                                        size: Dimensions.font12,
                                        color: Colors.white))
                                : Container()
                          ],
                        ),
                      );
                    })
                  ]),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(
                      child: BigText(
                          size: Dimensions.font26, text: product.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.height20),
                          topRight: Radius.circular(Dimensions.height20))),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: Dimensions.popularFoodImgSize,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppContants.BASE_URL + AppContants.Uploads_Uri + product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.height20, right: Dimensions.height20),
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description!),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.corner30 * 2.5,
                      right: Dimensions.corner30 * 2.5,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                            backgroungColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            size: Dimensions.height40,
                            iconSize: Dimensions.iconSize24,
                            icon: Icons.remove),
                      ),
                      BigText(
                        text:
                            "\$ ${product.price!} X ${controller.intCartItems}",
                        color: AppColors.mainBlackColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                            backgroungColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            size: Dimensions.height40,
                            iconSize: Dimensions.iconSize24,
                            icon: Icons.add),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Dimensions.botomTextBar,
                  padding: EdgeInsets.only(
                      top: Dimensions.corner30,
                      bottom: Dimensions.corner30,
                      left: Dimensions.height20,
                      right: Dimensions.height20),
                  decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.height20 * 2),
                        topRight: Radius.circular(Dimensions.height20 * 2),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 120,
                          padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              right: Dimensions.height20,
                              left: Dimensions.height20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.height20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: AppColors.mainColor,
                              ),
                            ],
                          )),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              right: Dimensions.height20,
                              left: Dimensions.height20),
                          child: BigText(
                            text: "\$ ${product.price!} | Add to Cart",
                            size: Dimensions.height15,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height15),
                              color: AppColors.mainColor),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
