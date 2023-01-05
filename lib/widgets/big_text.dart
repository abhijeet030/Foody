import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody/utils/dymansion.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  dynamic weight;
  TextOverflow overflow;
  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 20,
      this.weight = FontWeight.w500,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        //fontFamily: 'Roboto-Regular.ttf',
        fontWeight: weight,
        fontSize: size,
      ),
    );
  }
}
