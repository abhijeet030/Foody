import 'package:foody/data/repository/auth_repo.dart';
import 'package:foody/data/repository/user_repo.dart';
import 'package:foody/models/reposnse_model.dart';
import 'package:foody/models/signup_body_models.dart';
import 'package:foody/models/user_model.dart';
import 'package:foody/utils/app_constant.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  late UserModel _userModel;

  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print("test" + response.body.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      print('didn get');
      responseModel = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }
}
