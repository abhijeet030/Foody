import 'package:foody/data/api/api_client.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppContants.RECOMMENDED_PRODUCTS_URI);
  }
}
