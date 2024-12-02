import 'package:flutter/material.dart';

import '../atoms/colors.dart';

class ButtonStrokeColorScheme {
  const ButtonStrokeColorScheme({
    required this.defaultColor,
    required this.pressedColor,
    required this.disabledColor,
    required this.loadingColor,
  });

  final Color defaultColor;
  final Color pressedColor;
  final Color disabledColor;
  final Color loadingColor;
}

class ButtonColorScheme {
  final Color defaultBackgroundColor;
  final Color pressedBackgroundColor;
  final Color disabledBackgroundColor;
  final Color loadingBackgroundColor;

  final Color defaultForegroundColor;
  final Color pressedForegroundColor;
  final Color disabledForegroundColor;
  final Color loadingForegroundColor;
  final ButtonStrokeColorScheme? strokeColorScheme;

  const ButtonColorScheme({
    required this.defaultBackgroundColor,
    required this.pressedBackgroundColor,
    required this.disabledBackgroundColor,
    required this.loadingBackgroundColor,
    required this.defaultForegroundColor,
    required this.pressedForegroundColor,
    required this.disabledForegroundColor,
    required this.loadingForegroundColor,
    this.strokeColorScheme,
  });

  ButtonColorScheme copyWith({
    Color? defaultBackgroundColor,
    Color? pressedBackgroundColor,
    Color? disabledBackgroundColor,
    Color? loadingBackgroundColor,
    Color? defaultForegroundColor,
    Color? pressedForegroundColor,
    Color? disabledForegroundColor,
    Color? loadingForegroundColor,
    ValueGetter<ButtonStrokeColorScheme?>? strokeColorScheme,
  }) {
    return ButtonColorScheme(
      defaultBackgroundColor: defaultBackgroundColor ?? this.defaultBackgroundColor,
      pressedBackgroundColor: pressedBackgroundColor ?? this.pressedBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
      loadingBackgroundColor: loadingBackgroundColor ?? this.loadingBackgroundColor,
      defaultForegroundColor: defaultForegroundColor ?? this.defaultForegroundColor,
      pressedForegroundColor: pressedForegroundColor ?? this.pressedForegroundColor,
      disabledForegroundColor: disabledForegroundColor ?? this.disabledForegroundColor,
      loadingForegroundColor: loadingForegroundColor ?? this.loadingForegroundColor,
      strokeColorScheme:
          strokeColorScheme != null ? strokeColorScheme.call() : this.strokeColorScheme,
    );
  }
}

const primaryColorScheme = ButtonColorScheme(
  /// background
  defaultBackgroundColor: CvAppBasicColors.buttonBackgroundPrimaryEnabled,
  pressedBackgroundColor: CvAppBasicColors.buttonBackgroundPrimaryPressed,
  disabledBackgroundColor: CvAppBasicColors.buttonBackgroundDisabled,
  loadingBackgroundColor: CvAppBasicColors.buttonBackgroundPrimaryPressed,

  /// foreground
  defaultForegroundColor: CvAppBasicColors.buttonLabelPrimary,
  pressedForegroundColor: CvAppBasicColors.buttonLabelPrimary,
  disabledForegroundColor: CvAppBasicColors.buttonLabelDisabled,
  loadingForegroundColor: CvAppBasicColors.buttonLabelPrimary,
);

const secondaryColorScheme = ButtonColorScheme(
  /// background
  defaultBackgroundColor: Colors.transparent,
  pressedBackgroundColor: CvAppBasicColors.buttonBackgroundSecondaryPressed,
  disabledBackgroundColor: Colors.transparent,
  loadingBackgroundColor: Colors.transparent,

  strokeColorScheme: ButtonStrokeColorScheme(
    defaultColor: CvAppBasicColors.buttercup,
    pressedColor: CvAppBasicColors.buttercupLight,
    loadingColor: CvAppBasicColors.buttercup,
    disabledColor: CvAppBasicColors.buttonBackgroundDisabled,
  ),

  /// foreground
  defaultForegroundColor: Colors.transparent,
  pressedForegroundColor: Colors.transparent,
  disabledForegroundColor: CvAppBasicColors.buttonBackgroundDisabled,
  loadingForegroundColor: Colors.transparent,
);
