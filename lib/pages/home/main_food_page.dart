import 'package:flutter/material.dart';
import 'package:foody/controlers/popular_product_controller.dart';
import 'package:foody/controlers/recomended_product_controller.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody/pages/home/food_page_body.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:flutter/src/services/asset_bundle.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    //print("current height is " + MediaQuery.of(context).size.height.toString());
    return RefreshIndicator(
        child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height40, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.height20, right: Dimensions.height20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          BigText(
                            text: 'Rajasthan',
                            color: AppColors.mainColor,
                          ),
                          Row(
                            children: [
                              SmallText(
                                text: 'Jaipur',
                                color: AppColors.mainBlackColor,
                              ),
                              Icon(Icons.arrow_drop_down_rounded)
                            ],
                          )
                        ],
                      ),
                      Center(
                        child: Container(
                          width: Dimensions.height40,
                          height: Dimensions.height40,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.height15),
                            color: AppColors.mainColor,
                          ),
                        ),
                      )
                    ]),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: FoodPageBody(),
            )),
          ],
        ),
        onRefresh: _loadResources);
  }
}
