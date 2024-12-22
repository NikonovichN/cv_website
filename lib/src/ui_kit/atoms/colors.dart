import 'package:flutter/material.dart';

class CvAppBasicColors {
  CvAppBasicColors._();

  static const buttercup = Color.fromRGBO(251, 205, 75, 1.0);
  static const buttercupLight = Color.fromRGBO(255, 231, 161, 1.0);
  static const silverWare = Color.fromRGBO(163, 165, 153, 1.0);
  static const gloomy = Color.fromRGBO(40, 38, 35, 1.0);
  static const green = Color.fromRGBO(136, 165, 80, 1.0);
  static const greenLight = Color.fromRGBO(178, 199, 137, 1.0);
  static const softGrey = Color.fromRGBO(221, 222, 222, 1.0);
  static const acid = Color.fromRGBO(175, 206, 17, 1.0);

  static const smallHeartPink = Color.fromRGBO(206, 91, 91, 1);
  static const smallHeartYellow = Color.fromRGBO(218, 218, 28, 1.0);
  static const smallHeartTurquoise = Color.fromRGBO(182, 202, 84, 1);
  static const smallHeartWhite = Color.fromRGBO(244, 245, 241, 1);

  static const buttonBackgroundPrimaryEnabled = buttercup;
  static const buttonBackgroundPrimaryPressed = buttercupLight;
  static const buttonBackgroundDisabled = silverWare;
  static const buttonLabelPrimary = gloomy;
  static const buttonLabelDisabled = buttercupLight;

  static const buttonBackgroundSecondaryPressed = Color.fromARGB(22, 255, 211, 90);
}

class CvAppDarkColorsScheme extends ColorScheme {
  const CvAppDarkColorsScheme()
      : super(
          brightness: Brightness.light,
          primary: CvAppBasicColors.buttercup,
          onPrimary: CvAppBasicColors.gloomy,
          secondary: CvAppBasicColors.green,
          onSecondary: CvAppBasicColors.gloomy,
          error: Colors.red,
          onError: CvAppBasicColors.gloomy,
          surface: CvAppBasicColors.gloomy,
          onSurface: CvAppBasicColors.softGrey,
        );
}
