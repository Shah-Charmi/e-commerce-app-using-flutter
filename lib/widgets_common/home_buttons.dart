import 'package:e_commerce_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 26,
        ),
        5.heightBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    ).box.rounded.white.shadowSm.size(width, height).make(),
  );
}
