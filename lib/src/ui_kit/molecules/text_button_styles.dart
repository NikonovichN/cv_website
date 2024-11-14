import 'package:flutter/material.dart';

import '../atoms/fonts.dart';

final menuButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.menu),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
);

final menuHoverButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.hoverMenu),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
);

final menuActiveButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(CvAppFonts.activeMenu),
  overlayColor: WidgetStateProperty.all(Colors.transparent),
);
