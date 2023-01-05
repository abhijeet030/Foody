import 'package:foody/controlers/auth_controller.dart';
import 'package:foody/controlers/cart_controller.dart';
import 'package:foody/controlers/user_controller.dart';
import 'package:foody/data/repository/auth_repo.dart';
import 'package:foody/data/repository/cart_repo.dart';
import 'package:foody/data/repository/popular_product_repo.dart';
import 'package:foody/controlers/popular_product_controller.dart';
import 'package:foody/data/api/api_client.dart';
import 'package:foody/data/repository/user_repo.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controlers/recomended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> int() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppContants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
}
