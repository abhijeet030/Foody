import 'package:flutter/material.dart';
import 'package:foody/data/api/api_client.dart';
import 'package:foody/models/signup_body_models.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppContants.REGISTRATION_URI, signUpBody.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppContants.TOKEN);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppContants.TOKEN) ?? "None";
  }

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(
        AppContants.LOGIN_URI, {"phone": phone, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppContants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppContants.PHONE, number);
      await sharedPreferences.setString(AppContants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppContants.TOKEN);
    sharedPreferences.remove(AppContants.PASSWORD);
    sharedPreferences.remove(AppContants.PHONE);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
