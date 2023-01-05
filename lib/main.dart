import 'package:flutter/material.dart';
import 'package:foody/controlers/cart_controller.dart';
import 'package:foody/controlers/popular_product_controller.dart';
import 'package:foody/pages/auth/sign_in_page.dart';
import 'package:foody/pages/auth/sign_up_page.dart';
import 'package:foody/pages/cart/cart_page.dart';
import 'package:foody/pages/food/popular_food_details.dart';

import 'package:foody/pages/food/recomended_food_details.dart';
import 'package:foody/pages/home/main_food_page.dart';
import 'package:foody/pages/splash/splash_page.dart';
import 'package:foody/routes/routes_helper.dart';
import 'package:get/get.dart';
import 'controlers/recomended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.int();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          //home: SignInPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
