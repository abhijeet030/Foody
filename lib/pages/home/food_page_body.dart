// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody/controlers/recomended_product_controller.dart';
import 'package:foody/data/repository/recommended_product_repo.dart';
import 'package:foody/models/products_module.dart';
import 'package:foody/pages/food/popular_food_details.dart';
import 'package:foody/pages/food/recomended_food_details.dart';
import 'package:foody/routes/routes_helper.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/icon_and_text.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/src/services/asset_bundle.dart';
import 'package:get/get.dart';
import 'package:foody/utils/app_constant.dart';

import 'package:foody/controlers/popular_product_controller.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  //final controller = PageController(initialPage: 1);
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;
  int count = 0;
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        //print("current value is " + _currPageValue.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  //color: Colors.redAccent,
                  height: Dimensions.pageview,
                  child: PageView.builder(
                      controller: pageController,
                      //     controller: PageController(viewportFraction: 0.90),
                      itemCount: popularProducts.popularProductList.isEmpty
                          ? 1
                          : popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : Container();
        }),
        SizedBox(
          height: Dimensions.height10,
        ),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.corner30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.corner30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimensions.height10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.height10),
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: SmallText(text: 'Food Pairing'),
              )
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (comtext, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getRecommendedFood(index, "home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.height20,
                            right: Dimensions.height20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            Container(
                                width: Dimensions.listViewImageSize,
                                height: Dimensions.listViewImageSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.height20),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          AppContants.BASE_URL +
                                              AppContants.Uploads_Uri +
                                              recommendedProduct
                                                  .recommendedProductList[index]
                                                  .img!,
                                        ),
                                        fit: BoxFit.cover))),
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextContainer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.height20),
                                      bottomRight:
                                          Radius.circular(Dimensions.height20)),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.height10,
                                      right: Dimensions.height10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Dimensions.height7,
                                        ),
                                        BigText(
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .name!),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(
                                          text: 'Spain special food',
                                        ),
                                        SizedBox(
                                          height: Dimensions.height15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                                icon: Icons.circle_sharp,
                                                text: 'Normal',
                                                color: AppColors.textColor,
                                                iconColor:
                                                    AppColors.yellowColor),
                                            IconAndTextWidget(
                                                icon: Icons.location_on,
                                                text: '1.7 Mile',
                                                color: AppColors.textColor,
                                                iconColor: AppColors.mainColor),
                                            IconAndTextWidget(
                                                icon: Icons.timer,
                                                text: '30 min',
                                                color: AppColors.textColor,
                                                iconColor:
                                                    AppColors.iconColor2),
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.height10, right: Dimensions.height10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      image: NetworkImage(
                        AppContants.BASE_URL +
                            AppContants.Uploads_Uri +
                            popularProduct.img!,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.corner30),
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 0),
                      )
                    ]),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.height15,
                      right: Dimensions.height15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: popularProduct.name!),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: AppColors.mainColor,
                                      size: Dimensions.height15,
                                    )),
                          ),
                          SizedBox(
                            width: Dimensions.height10,
                          ),
                          SmallText(text: '4.5'),
                          SizedBox(
                            width: Dimensions.height10,
                          ),
                          SmallText(
                            text: '1234',
                          ),
                          SizedBox(
                            width: Dimensions.font5,
                          ),
                          SmallText(text: 'Comments'),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(
                              icon: Icons.circle_rounded,
                              text: 'Normal',
                              color: AppColors.textColor,
                              iconColor: AppColors.yellowColor),
                          IconAndTextWidget(
                              icon: Icons.location_on,
                              text: '1.7 Mile',
                              color: AppColors.textColor,
                              iconColor: AppColors.mainColor),
                          IconAndTextWidget(
                              icon: Icons.watch_later_outlined,
                              text: '30 min',
                              color: AppColors.textColor,
                              iconColor: AppColors.iconColor2),
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
