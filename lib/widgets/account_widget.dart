import 'package:flutter/material.dart';
import 'package:foody/pages/food/app_icon.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.height20,
          top: Dimensions.height10,
          bottom: Dimensions.height10),
      child: Row(children: [
        appIcon,
        SizedBox(
          width: Dimensions.height20,
        ),
        bigText
      ]),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2))
      ]),
    );
  }
}
