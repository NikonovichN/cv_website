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

  static const TextStyle activeMenu = TextStyle(
    fontSize: 20,
    fontFamily: oswaldFontFamily,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle hoverMenu = menu;

  static const TextStyle link = TextStyle(
    fontSize: 18,
    fontFamily: robotoFontFamily,
    fontWeight: FontWeight.w200,
  );

  static const TextStyle activeLink = TextStyle(
    fontSize: 18,
    fontFamily: robotoFontFamily,
    fontWeight: FontWeight.w300,
    decoration: TextDecoration.underline,
  );

  static const TextStyle hoverLink = link;

  static const TextStyle header = TextStyle(
    fontSize: 40,
    fontFamily: oswaldFontFamily,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle primaryButton = TextStyle(
    fontSize: 16,
    fontFamily: oswaldFontFamily,
    fontWeight: FontWeight.w400,
  );
}
