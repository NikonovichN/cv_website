import 'package:flutter/material.dart';

class CvAppFonts {
  const CvAppFonts._();

  static const oswaldFontFamily = 'Oswald';
  static const robotoFontFamily = 'Roboto';

  static const TextStyle robotoRegular = TextStyle(
    fontSize: 24,
    fontFamily: robotoFontFamily,
    fontWeight: FontWeight.normal,
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
}
