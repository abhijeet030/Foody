import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dymansion.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                        size: Dimensions.height15,
                      )),
            ),
            SizedBox(
              width: Dimensions.height10,
            ),
            SmallText(text: '4.5'),
            SizedBox(
              width: Dimensions.height10,
            ),
            SmallText(
              text: '1234',
            ),
            SizedBox(
              width: Dimensions.font5,
            ),
            SmallText(text: 'Comments'),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: 'Normal',
                color: AppColors.textColor,
                iconColor: AppColors.yellowColor),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: '1.7 Mile',
                color: AppColors.textColor,
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.timer,
                text: '30 min',
                color: AppColors.textColor,
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
