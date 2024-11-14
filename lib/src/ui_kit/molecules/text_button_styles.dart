import 'package:flutter/material.dart';

import '../atoms/fonts.dart';
import '../atoms/colors.dart';

final menuButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.menu),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercup),
);

final menuHoverButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.hoverMenu),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercupLight),
);

final menuActiveButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.activeMenu),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercup),
);
