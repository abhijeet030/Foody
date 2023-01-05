import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foody/Base/no_data_page.dart';
import 'package:foody/controlers/cart_controller.dart';
import 'package:foody/models/cart_model.dart';
import 'package:foody/pages/food/app_icon.dart';
import 'package:foody/routes/routes_helper.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputDate,
        size: Dimensions.font16,
      );
    }

    return Scaffold(
      body: Column(children: [
        Container(
          height: Dimensions.height20 * 5,
          color: AppColors.mainColor,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimensions.height15 * 3),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            BigText(
              text: 'Cart History',
              color: Colors.white,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getCartPage());
              },
              child: AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: AppColors.mainColor,
              ),
            ),
          ]),
        ),
        GetBuilder<CartController>(builder: (_cartController) {
          return _cartController.getCartHistoryList().length > 0
              ? Expanded(
                  child: Container(
                      height: Dimensions.height20 * 6,
                      margin: EdgeInsets.only(
                        top: Dimensions.height20,
                        left: Dimensions.height20,
                        right: Dimensions.height20,
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timeWidget(listCounter),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  itemsPerOrder[i], (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        height: Dimensions
                                                                .height40 *
                                                            2,
                                                        width: Dimensions
                                                                .height40 *
                                                            2,
                                                        margin: EdgeInsets.only(
                                                            right: Dimensions
                                                                    .height10 /
                                                                2),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                            .height15 /
                                                                        2),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(AppContants
                                                                        .BASE_URL +
                                                                    AppContants
                                                                        .Uploads_Uri +
                                                                    getCartHistoryList[
                                                                            listCounter -
                                                                                1]
                                                                        .img!))),
                                                      )
                                                    : Container();
                                              })),
                                          Container(
                                              height: Dimensions.height40 * 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SmallText(
                                                    text: 'Total',
                                                    color: AppColors.titleColor,
                                                  ),
                                                  BigText(
                                                    text: itemsPerOrder[i]
                                                            .toString() +
                                                        " Items",
                                                    color: AppColors.titleColor,
                                                    size: Dimensions.font16,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      var orderTime =
                                                          cartOrderTimeToList();
                                                      Map<int, CartModel>
                                                          moreOrder = {};
                                                      for (int j = 0;
                                                          j <
                                                              getCartHistoryList
                                                                  .length;
                                                          j++) {
                                                        if (getCartHistoryList[
                                                                    j]
                                                                .time ==
                                                            orderTime[i]) {
                                                          moreOrder.putIfAbsent(
                                                              getCartHistoryList[
                                                                      j]
                                                                  .id!,
                                                              () => CartModel.fromJson(
                                                                  jsonDecode(jsonEncode(
                                                                      getCartHistoryList[
                                                                          j]))));
                                                        }
                                                      }
                                                      Get.find<CartController>()
                                                          .setItems = moreOrder;
                                                      Get.find<CartController>()
                                                          .addToCartList();
                                                      Get.toNamed(
                                                          RouteHelper.cartPage);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            Dimensions.height10,
                                                        vertical: Dimensions
                                                                .height10 /
                                                            2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .height10 /
                                                                2),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .mainColor),
                                                      ),
                                                      child: SmallText(
                                                        text: 'One More',
                                                        color:
                                                            AppColors.mainColor,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ))
                                        ],
                                      )
                                    ]),
                              )
                          ],
                        ),
                      )))
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: NoDataPage(
                    text: "You didn't purchased anithing yet",
                    imgPath: "assets/EmpteyHistory-01.png",
                  ));
        })
      ]),
    );
  }
}
