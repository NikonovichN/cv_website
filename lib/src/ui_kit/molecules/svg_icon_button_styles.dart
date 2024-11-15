import 'package:flutter/material.dart';

import '../atoms/colors.dart';

final svgIconStyle = ButtonStyle(
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercup),
);

final svgHoverIconStyle = ButtonStyle(
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  foregroundColor: WidgetStateProperty.all(CvAppBasicColors.buttercupLight),
);
