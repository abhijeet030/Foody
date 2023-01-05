import 'package:flutter/material.dart';
import 'package:foody/data/api/api_client.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:get/get_connect.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppContants.USER_INFO_URI);
  }
}
