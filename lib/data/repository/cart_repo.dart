import 'dart:convert';

import 'package:foody/models/cart_model.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    //sharedPreferences.remove(AppContants.Cart_List);
    //sharedPreferences.remove(AppContants.Cart_History_List);
    //return;
    var time = DateTime.now().toString();
    cart = [];

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppContants.Cart_List, cart);

    //print(sharedPreferences.getStringList(AppContants.Cart_List));
    //getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppContants.Cart_List)) {
      carts = sharedPreferences.getStringList(AppContants.Cart_List)!;
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppContants.Cart_History_List)) {
      // cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppContants.Cart_History_List)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppContants.Cart_History_List)) {
      cartHistory =
          sharedPreferences.getStringList(AppContants.Cart_History_List)!;
    }
    for (int i = 0; i < cart.length; i++) {
      //print('his list ' + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();

    sharedPreferences.setStringList(AppContants.Cart_History_List, cartHistory);
    //print("the leength of the history is " +
    //  getCartHistoryList().length.toString());

    for (int i = 0; i < getCartHistoryList().length; i++) {
      //print("time of the order " + getCartHistoryList()[i].time.toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppContants.Cart_List);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppContants.Cart_History_List);
  }
}
