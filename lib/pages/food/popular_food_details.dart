//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/controlers/cart_controller.dart';
import 'package:foody/pages/food/app_column.dart';
import 'package:foody/pages/food/app_icon.dart';
import 'package:foody/pages/food/expandable_text_widget.dart';
import 'package:foody/pages/home/main_food_page.dart';
import 'package:foody/routes/routes_helper.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
//import 'package:flutter/src/services/asset_bundle.dart';
import '../../controlers/popular_product_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../cart/cart_page.dart';
//import '../../widgets/icon_and_text.dart';
//import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    // print('page is id' + pageId.toString());
    // print('product name is ' + product.name.toString());
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                  width: double.maxFinite,
                  height: Dimensions.popularFoodImgSize,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppContants.BASE_URL +
                              AppContants.Uploads_Uri +
                              product.img!))))),
          //icon widget
          Positioned(
              top: Dimensions.height40 * 1.4,
              left: Dimensions.height20,
              right: Dimensions.height20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == 'cartpage') {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
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
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: Dimensions.font12,
                                      color: Colors.white))
                              : Container()
                        ],
                      ),
                    );
                  })
                ],
              )),
          //introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                    left: Dimensions.height20,
                    right: Dimensions.height20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.height20),
                      topLeft: Radius.circular(Dimensions.height20)),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: product.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: 'Introduction'),
                    SizedBox(height: Dimensions.height20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
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
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.height10 / 2,
                      ),
                      BigText(text: popularProduct.intCartItems.toString()),
                      SizedBox(
                        width: Dimensions.height10 / 2,
                      ),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(Icons.add, color: AppColors.signColor)),
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      right: Dimensions.height20,
                      left: Dimensions.height20),
                  child: BigText(
                    text: "\$ ${product.price!}  | Add to Cart",
                    size: Dimensions.height15,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height15),
                      color: AppColors.mainColor),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
