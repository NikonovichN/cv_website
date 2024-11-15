import 'package:cv_website/src/assets/fonts.gen.dart';
import 'package:flutter/material.dart';

class CvAppFonts {
  const CvAppFonts._();

  static const oswaldFontFamily = FontFamily.oswald;
  static const robotoFontFamily = FontFamily.roboto;

  static const TextStyle robotoRegular = TextStyle(
    fontSize: 24,
    fontFamily: robotoFontFamily,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle robotoSmallRegular = TextStyle(
    fontSize: 14,
    fontFamily: robotoFontFamily,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle menu = TextStyle(
    fontSize: 20,
    fontFamily: oswaldFontFamily,
    fontWeight: FontWeight.w200,
  );

  static const TextStyle hoverMenu = menu;

  static const TextStyle activeMenu = TextStyle(
    fontSize: 20,
    fontFamily: oswaldFontFamily,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle header = TextStyle(
    fontSize: 40,
    fontFamily: oswaldFontFamily,
    fontWeight: FontWeight.bold,
  );
}
