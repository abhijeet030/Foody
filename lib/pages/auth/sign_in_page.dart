import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foody/Base/custom_loader.dart';
import 'package:foody/Base/show_custom_snackbar.dart';
import 'package:foody/controlers/auth_controller.dart';
import 'package:foody/pages/auth/sign_up_page.dart';
import 'package:foody/routes/routes_helper.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/app_text_feild.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    //var emailController = TextEditingController();

    void _login(AuthController authController) {
      //String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
/*
      if (email.isEmpty) {
        showCustomSnackBar('Type in your email', title: 'Email');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('In valid email', title: 'Email');
      } else */

      if (phone.isEmpty) {
        showCustomSnackBar('Type in your registerd phone number',
            title: 'Phone');
      } else if (password.isEmpty) {
        showCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password must contain 6 character',
            title: 'password');
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            print("sucess login");
            Get.toNamed(RouteHelper.getSplashPage());
          } else {
            print("fail login");
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  SizedBox(
                    height: Dimensions.screenHeight * 0.075,
                  ),
                  Container(
                    height: Dimensions.screenHeight * 0.15,
                    child: Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          'assets/singup.png',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.height20),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: 'Hello',
                          weight: FontWeight.w700,
                          size: Dimensions.height40 * 2.25,
                          color: AppColors.mainBlackColor,
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.002,
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Sign into your account',
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  AppTextField(
                      hintText: 'phone',
                      iconData: Icons.phone,
                      textEditingController: phoneController),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  AppTextField(
                      hintText: 'Password',
                      isObscured: true,
                      iconData: Icons.key,
                      textEditingController: passwordController),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.height20),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Sign into your account',
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.075,
                  ),
                  GestureDetector(
                    onTap: () {
                      _login(authController);
                    },
                    child: Container(
                      width: Dimensions.screenwidth / 2,
                      height: Dimensions.screenHeight / 13,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.corner30),
                          color: AppColors.mainColor),
                      child: Center(
                        child: BigText(
                          text: 'Sign in',
                          size: Dimensions.height15 * 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font16)),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => SignUpPage()),
                        child: BigText(
                          text: "Create",
                          size: Dimensions.font16,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ]),
              )
            : CustomLoader();
      }),
    );
  }
}
