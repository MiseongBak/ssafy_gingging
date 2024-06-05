import 'package:flutter/material.dart';

import '../constant/app_colors.dart';
import 'custom_font_weight.dart';

class CustomFontStyle {
  static TextStyle getTextStyle(BuildContext context, TextStyle baseStyle) {
    double width = MediaQuery.of(context).size.width;
    double scaleFactor = width / 1480;
    return baseStyle.copyWith(fontSize: baseStyle.fontSize! * scaleFactor);
  }

  /// Typography
  static const cuteFont = TextStyle(
    fontFamily: "CuteFont",
    fontSize: 40,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung50 = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 50,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung90 = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 90,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung80 = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 80,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung70 = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 70,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung60 = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 60,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung150 = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 150,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung200 = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 200,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung100 = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 100,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung300 = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 300,
    color: Colors.black,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung50_white = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 40,
    color: Colors.white,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung55_white = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 50,
    color: Colors.white,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung90_white = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 90,
    color: Colors.white,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung80_white = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 80,
    color: Colors.white,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung70_white = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 70,
    color: Colors.white,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung60_white = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 60,
    color: Colors.white,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung200_white = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 200,
    color: Colors.white,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung140_white = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 140,
    color: Colors.white,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung300_white = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 300,
    color: Colors.white,
    fontWeight: CustomFontWeight.semiBold,
  );
}
