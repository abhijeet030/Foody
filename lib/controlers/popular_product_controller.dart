import 'package:flutter/material.dart';
import 'package:foody/controlers/cart_controller.dart';
import 'package:foody/data/repository/popular_product_repo.dart';
import 'package:foody/models/products_module.dart';
import 'package:foody/utils/colors.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _intCartItems = 0;
  int get intCartItems => _intCartItems + _quantity;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);

      _isLoaded = true;
      update();
    } else {}
  }

  // void setQuantity(bool isIncrement) {
  //   if (isIncrement) {
  //     if (quantity < 20) {
  //       _quantity = _quantity + 1;
  //     } else {
  //       Get.snackbar(
  //         "Item count",
  //         "You can't add more !",
  //         backgroundColor: AppColors.mainColor,
  //         colorText: Colors.white,
  //       );
  //       _quantity = 20;
  //     }
  //   } else {
  //     if ((_intCartItems + quantity) > 0) {
  //       _quantity = _quantity - 1;
  //     } else {
  //       _quantity = 0;
  //       Get.snackbar(
  //         "Item count",
  //         "You did not added any thing yet !",
  //         backgroundColor: AppColors.mainColor,
  //         colorText: Colors.white,
  //       );
  //     }
  //   }
  //   update();
  // }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      //print("number of items " + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      //print("number of items " + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_intCartItems + quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You did not added any thing yet !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_intCartItems > 0) {
        _quantity = -_intCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_intCartItems + quantity) > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _intCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    print('exist or not ' + exist.toString());
    if (exist) {
      _intCartItems = _cart.getQuantity(product);
    }
    print('the quantity in the cart is ' + _intCartItems.toString());
  }

  void addItem(ProductModel product) {
    // if (_quantity > 0) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _intCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("the id is " +
          value.id.toString() +
          " the quantity is " +
          value.quantity.toString());
    });
    // } else {
    //   Get.snackbar(
    //     "Item count",
    //     "You should add at least add an item in the cart!",
    //     backgroundColor: AppColors.mainColor,
    //     colorText: Colors.white,
    //   );
    // }
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItem {
    return _cart.getItem;
  }
}
