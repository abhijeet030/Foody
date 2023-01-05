import 'package:flutter/material.dart';
import 'package:foody/Base/no_data_page.dart';
import 'package:foody/controlers/auth_controller.dart';
import 'package:foody/controlers/cart_controller.dart';
import 'package:foody/controlers/popular_product_controller.dart';
import 'package:foody/controlers/recomended_product_controller.dart';
import 'package:foody/pages/food/app_icon.dart';
import 'package:foody/pages/home/main_food_page.dart';
import 'package:foody/routes/routes_helper.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.height20,
              right: Dimensions.height20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroungColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.height20 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroungColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCartHistory());
                    },
                    child: AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroungColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  )
                ],
              )),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItem.length > 0
                ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.height20,
                    right: Dimensions.height20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height15),
                      //color: Colors.red,
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (CartController) {
                              var _cartList = CartController.getItem;
                              return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      height: Dimensions.height20 * 5,
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        'cartpage'));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index]
                                                        .product!);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                      "History Product",
                                                      "Product review is not avilable for history product!",
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      colorText: Colors.white);
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          'cartpage'));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: Dimensions.height20 * 5,
                                              height: Dimensions.height20 * 5,
                                              margin: EdgeInsets.only(
                                                  bottom: Dimensions.height10),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppContants.BASE_URL +
                                                              AppContants
                                                                  .Uploads_Uri +
                                                              CartController
                                                                  .getItem[
                                                                      index]
                                                                  .img!)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.height20),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.height10,
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: CartController
                                                      .getItem[index].name!,
                                                  color: Colors.black54,
                                                ),
                                                SmallText(text: "spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text: "\$ " +
                                                          CartController
                                                              .getItem[index]
                                                              .price!
                                                              .toString(),
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(
                                                            top: Dimensions
                                                                .height10,
                                                            bottom: Dimensions
                                                                .height10,
                                                            right: Dimensions
                                                                .height10,
                                                            left: Dimensions
                                                                .height10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .height10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                CartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .signColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimensions
                                                                      .height10 /
                                                                  2,
                                                            ),
                                                            BigText(
                                                                text: _cartList[
                                                                        index]
                                                                    .quantity
                                                                    .toString()), //popularProduct.intCartItems.toString()),
                                                            SizedBox(
                                                              width: Dimensions
                                                                      .height10 /
                                                                  2,
                                                            ),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  CartController.addItem(
                                                                      _cartList[
                                                                              index]
                                                                          .product!,
                                                                      1);
                                                                },
                                                                child: Icon(
                                                                    Icons.add,
                                                                    color: AppColors
                                                                        .signColor)),
                                                          ],
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    );
                                  });
                            },
                          )),
                    ))
                : NoDataPage(
                    text: "Your Cart is Empty!",
                  );
          })
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
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
            child: cartController.getItem.length > 0
                ? Row(
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
                              SizedBox(
                                width: Dimensions.height10 / 2,
                              ),
                              BigText(
                                  text: "\$ " +
                                      cartController.totalAmount.toString()),
                              SizedBox(
                                width: Dimensions.height10 / 2,
                              ),
                            ],
                          )),
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().userLoggedIn()) {
                            cartController.addToHistory();
                          } else {
                            Get.toNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              right: Dimensions.height20,
                              left: Dimensions.height20),
                          child: BigText(
                            text: "Check Out",
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
                  )
                : Container());
      }),
    );
  }
}
