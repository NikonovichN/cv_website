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

  static const smallHeartRed = Color.fromRGBO(220, 40, 40, 1.0);
  static const smallHeartYellow = Color.fromRGBO(218, 218, 28, 1.0);
  static const smallHeartBlue = Color.fromRGBO(63, 28, 218, 1.0);
  static const smallHeartTurquoise = Color.fromRGBO(175, 206, 17, 1.0);

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
