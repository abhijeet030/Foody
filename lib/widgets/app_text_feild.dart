import 'package:flutter/material.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData iconData;
  bool isObscured;
  AppTextField(
      {Key? key,
      required this.hintText,
      required this.iconData,
      required this.textEditingController,
      this.isObscured = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.height15),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextField(
        obscureText: isObscured,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            iconData,
            color: AppColors.yellowColor,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.height15),
              borderSide: BorderSide(width: 1.0, color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.height15),
              borderSide: BorderSide(width: 1.0, color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height15),
          ),
        ),
      ),
    );
  }
}
