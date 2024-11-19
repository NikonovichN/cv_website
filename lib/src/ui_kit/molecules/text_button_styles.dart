import 'package:flutter/material.dart';

import '../atoms/fonts.dart';
import '../atoms/colors.dart';

final menuButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.menu),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercup),
  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 2.0)),
  minimumSize: const WidgetStatePropertyAll(Size(0.0, 0.0)),
);

final menuHoverButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.hoverMenu),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercupLight),
  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 2.0)),
  minimumSize: const WidgetStatePropertyAll(Size(0.0, 0.0)),
);

final menuActiveButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.activeMenu),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercup),
  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 2.0)),
  minimumSize: const WidgetStatePropertyAll(Size(0.0, 0.0)),
);

final linkButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.link),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercup),
  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 2.0)),
  minimumSize: const WidgetStatePropertyAll(Size(0.0, 0.0)),
);

final linkHoverButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.hoverLink),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercupLight),
  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 2.0)),
  minimumSize: const WidgetStatePropertyAll(Size(0.0, 0.0)),
);

final linkActiveButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.activeLink),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercup),
  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 2.0)),
  minimumSize: const WidgetStatePropertyAll(Size(0.0, 0.0)),
);
