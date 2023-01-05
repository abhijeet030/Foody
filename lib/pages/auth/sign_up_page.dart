import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foody/Base/custom_loader.dart';
import 'package:foody/Base/show_custom_snackbar.dart';
import 'package:foody/controlers/auth_controller.dart';
import 'package:foody/models/signup_body_models.dart';
import 'package:foody/routes/routes_helper.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/app_text_feild.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void _registeration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar('Type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Type in your phone number', title: 'Phone Number');
      } else if (email.isEmpty) {
        showCustomSnackBar('Type in your email', title: 'Email');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('In valid email', title: 'Email');
      } else if (password.isEmpty) {
        showCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password must contain 6 character',
            title: 'password');
      } else {
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar('All went well',
                title: "Perfect", backgroundColor: Colors.green);
            print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
        print(signUpBody.toString());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  Container(
                    height: Dimensions.screenHeight * 0.25,
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
                  AppTextField(
                      hintText: 'Email',
                      iconData: Icons.email,
                      textEditingController: emailController),
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
                  AppTextField(
                      hintText: 'Phone Number',
                      iconData: Icons.phone,
                      textEditingController: phoneController),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  AppTextField(
                      hintText: 'Name',
                      iconData: Icons.person,
                      textEditingController: nameController),
                  SizedBox(
                    height: Dimensions.height40,
                  ),
                  GestureDetector(
                    onTap: () {
                      _registeration(_authController);
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
                          text: 'Sign UP',
                          size: Dimensions.height15 * 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: 'Have an account already?',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16)),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Sign up using one of the following methods',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font12)),
                  ),
                  Wrap(
                      children: List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: Dimensions.corner30,
                          backgroundImage: AssetImage(
                            "assets/" + signUpImages[index],
                          )),
                    ),
                  )),
                ]),
              )
            : const CustomLoader();
      }),
    );
  }
}
