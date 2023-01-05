import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foody/controlers/popular_product_controller.dart';
import 'package:foody/controlers/recomended_product_controller.dart';
import 'package:foody/routes/routes_helper.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    animation = new CurvedAnimation(
      parent: controller,
      curve: Curves.bounceOut,
    );
    Timer(Duration(seconds: 3), () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Center(
                child: Image.asset(
                  'assets/Applogo.png',
                  width: Dimensions.height40 * 4,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            BigText(
              text: "Food Express",
              color: AppColors.titleColor,
            ),
          ]),
    );
  }
}
