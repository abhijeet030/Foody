import 'package:flutter/material.dart';
import 'package:foody/Base/custom_loader.dart';
import 'package:foody/Base/no_data_page.dart';
import 'package:foody/Base/show_custom_snackbar.dart';
import 'package:foody/controlers/auth_controller.dart';
import 'package:foody/controlers/cart_controller.dart';
import 'package:foody/controlers/user_controller.dart';
import 'package:foody/pages/food/app_icon.dart';
import 'package:foody/routes/routes_helper.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/account_widget.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: BigText(
              text: 'Profile',
              color: Colors.white,
              size: Dimensions.font12 * 2,
            ),
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(
                        children: [
                          //profile icon
                          AppIcon(
                            icon: Icons.person,
                            backgroungColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height15 * 5,
                            size: Dimensions.height15 * 10,
                          ),
                          SizedBox(
                            height: Dimensions.corner30,
                          ),
                          //name
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroungColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.name,
                                      )),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //telephone
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroungColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.phone,
                                      )),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //email
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroungColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.email,
                                      )),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //address
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on_outlined,
                                        backgroungColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: 'Enter your location',
                                      )),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //message
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message,
                                        backgroungColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: 'Message',
                                      )),

                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //message
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        showCustomSnackBar(
                                            'You are Logged Out!',
                                            title: 'Log out',
                                            backgroundColor:
                                                AppColors.mainColor);
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      } else {
                                        showCustomSnackBar('Not logged in!',
                                            title: 'Log In');
                                        //Get.offNamed(RouteHelper.getSignInPage());
                                      }
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backgroungColor: Colors.red,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                          text: 'Log Out',
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : CustomLoader())
              : Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.2,
                        ),
                        NoDataPage(
                          text: "Login First",
                          imgPath: "assets/login.png",
                        ),
                        SizedBox(
                          height: Dimensions.height40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20,
                                right: Dimensions.height20,
                                left: Dimensions.height20),
                            child: BigText(
                              text: "Log In",
                              size: Dimensions.height15 * 1.5,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.height15),
                                color: AppColors.mainColor),
                          ),
                        )
                      ],
                    ),
                  ),
                );
        }));
  }
}
