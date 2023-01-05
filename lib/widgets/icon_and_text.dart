import 'package:flutter/cupertino.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;

  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.font20,
        ),
        SizedBox(
          width: Dimensions.font5,
        ),
        SmallText(
          text: text,
          color: color,
        ),
      ],
    );
  }
}
