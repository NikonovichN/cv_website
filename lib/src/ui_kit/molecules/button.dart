import 'package:flutter/material.dart';

import '../atoms/fonts.dart';
import '../atoms/colors.dart';
import '../atoms/radiuses.dart';

import 'button_styles.dart';

class CvAppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonColorScheme colorScheme;
  final TextStyle? textStyle;
  final Color? textColor;
  final bool isLoading;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CvAppButton({
    super.key,
    this.onPressed,
    required this.child,
    this.colorScheme = primaryColorScheme,
    this.textStyle,
    this.textColor,
    this.isLoading = false,
    this.elevation = 0,
    this.padding,
    this.margin,
  });

  const CvAppButton.primary({
    super.key,
    this.onPressed,
    required this.child,
    this.colorScheme = primaryColorScheme,
    this.textStyle = CvAppFonts.primaryButton,
    this.textColor = CvAppBasicColors.gloomy,
    this.isLoading = false,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
  });

  const CvAppButton.secondary({
    super.key,
    this.onPressed,
    required this.child,
    this.colorScheme = secondaryColorScheme,
    this.textStyle = CvAppFonts.primaryButton,
    this.textColor = CvAppBasicColors.buttercup,
    this.isLoading = false,
    this.elevation = 0,
    this.padding = const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(_backgroundColor),
          overlayColor: WidgetStateProperty.resolveWith(_backgroundColor),
          foregroundColor: WidgetStateProperty.resolveWith(_foregroundColor),
          elevation: WidgetStateProperty.resolveWith(_elevation),
          shape: WidgetStateProperty.resolveWith(_shape),
          padding: WidgetStateProperty.resolveWith(_padding),
        ),
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style.merge(textStyle?.copyWith(color: textColor)),
          child: child,
        ),
      ),
    );
  }

  Color _backgroundColor(Set<WidgetState> states) {
    if (isLoading) {
      return colorScheme.loadingBackgroundColor;
    }
    if (states.contains(WidgetState.disabled)) {
      return colorScheme.disabledBackgroundColor;
    }
    if (states.contains(WidgetState.pressed)) {
      return colorScheme.pressedBackgroundColor;
    }
    return colorScheme.defaultBackgroundColor;
  }

  Color _foregroundColor(Set<WidgetState> states) {
    if (isLoading) {
      return colorScheme.loadingForegroundColor;
    }
    if (states.contains(WidgetState.disabled)) {
      return colorScheme.disabledForegroundColor;
    }
    if (states.contains(WidgetState.pressed)) {
      return colorScheme.pressedForegroundColor;
    }
    return colorScheme.defaultForegroundColor;
  }

  OutlinedBorder? _shape(Set<WidgetState> states) {
    return RoundedRectangleBorder(
      borderRadius: CvAppRadius.borderLg,
      side: colorScheme.strokeColorScheme != null
          ? BorderSide(
              width: 1,
              color: _strokeColor(colorScheme.strokeColorScheme!, states),
            )
          : BorderSide.none,
    );
  }

  Color _strokeColor(ButtonStrokeColorScheme colorScheme, Set<WidgetState> states) {
    if (isLoading) {
      return colorScheme.loadingColor;
    }
    if (states.contains(WidgetState.disabled)) {
      return colorScheme.disabledColor;
    }
    if (states.contains(WidgetState.pressed)) {
      return colorScheme.pressedColor;
    }
    return colorScheme.defaultColor;
  }

  double? _elevation(Set<WidgetState> states) {
    if (isLoading) {
      return 0;
    }
    if (states.contains(WidgetState.disabled)) {
      return 0;
    }
    if (states.contains(WidgetState.pressed)) {
      return 0;
    }
    return elevation;
  }

  EdgeInsetsGeometry? _padding(Set<WidgetState> states) {
    return padding ?? EdgeInsets.zero;
  }
}
