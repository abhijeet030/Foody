import 'package:foody/pages/auth/sign_in_page.dart';
import 'package:foody/pages/cart/cart_page.dart';
import 'package:foody/pages/food/popular_food_details.dart';
import 'package:foody/pages/food/recomended_food_details.dart';
import 'package:foody/pages/home/home_page.dart';
import 'package:foody/pages/home/main_food_page.dart';
import 'package:foody/pages/splash/splash_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_history.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String cartHistory = "/cart-history";
  static const String signIn = "/sign-in";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getCartHistory() => '$cartHistory';
  static String getSignInPage() => '$signIn';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(
        name: initial,
        page: () {
          return HomePage();
        }),
    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return RecommendeFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: cartHistory,
        page: () {
          return CartHistory();
        },
        transition: Transition.rightToLeftWithFade),
  ];
}
