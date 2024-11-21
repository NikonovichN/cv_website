import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../atoms/colors.dart';
import 'svg_icon_button_styles.dart';

class CvAppSvgIconButton extends StatelessWidget {
  final String iconPath;
  final void Function()? onPressed;
  final ButtonStyle? style;
  final ButtonStyle? hoverStyle;

  const CvAppSvgIconButton({
    super.key,
    required this.iconPath,
    this.onPressed,
    this.style,
    this.hoverStyle,
  });

  CvAppSvgIconButton.primary({
    super.key,
    required this.iconPath,
    this.onPressed,
  })  : style = svgIconStyle,
        hoverStyle = svgHoverIconStyle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.resolveWith(_overlayColor),
        foregroundColor: WidgetStateProperty.resolveWith(_foregroundColor),
      ),
      icon: SvgPicture.asset(
        iconPath,
        colorFilter: const ColorFilter.mode(
          CvAppBasicColors.buttercup,
          BlendMode.srcIn,
        ),
      ),
      onPressed: onPressed,
    );
  }

  Color? _overlayColor(Set<WidgetState> state) {
    if (state.contains(WidgetState.hovered)) {
      return hoverStyle?.overlayColor?.resolve(state);
    }

    return style?.overlayColor?.resolve(state);
  }

  Color? _foregroundColor(Set<WidgetState> state) {
    if (state.contains(WidgetState.hovered)) {
      return hoverStyle?.foregroundColor?.resolve(state);
    }

    return style?.foregroundColor?.resolve(state);
  }
}
