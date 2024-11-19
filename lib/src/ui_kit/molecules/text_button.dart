import 'package:flutter/material.dart';

import 'text_button_styles.dart';

class SvAppTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final ButtonStyle? hoverStyle;
  final ButtonStyle? activeStyle;
  final bool isActive;

  const SvAppTextButton({
    super.key,
    this.onPressed,
    required this.child,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.hoverStyle,
    this.activeStyle,
    this.isActive = false,
  });

  SvAppTextButton.menu({
    super.key,
    this.onPressed,
    required this.child,
    this.onHover,
    this.onFocusChange,
    required this.isActive,
  })  : style = menuButtonStyle,
        hoverStyle = menuHoverButtonStyle,
        activeStyle = menuActiveButtonStyle;

  SvAppTextButton.link({
    super.key,
    this.onPressed,
    required this.child,
    this.onHover,
    this.onFocusChange,
    required this.isActive,
  })  : style = linkButtonStyle,
        hoverStyle = linkHoverButtonStyle,
        activeStyle = linkActiveButtonStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: ButtonStyle(
        textStyle: WidgetStateProperty.resolveWith(_textStyle),
        overlayColor: WidgetStateProperty.resolveWith(_overlayColor),
        foregroundColor: WidgetStateProperty.resolveWith(_foregroundColor),
        padding: WidgetStateProperty.resolveWith(_padding),
        minimumSize: WidgetStateProperty.resolveWith(_minimumSize),
      ),
      child: child,
    );
  }

  TextStyle? _textStyle(Set<WidgetState> state) {
    if (isActive) {
      return activeStyle?.textStyle?.resolve(state);
    }

    if (state.contains(WidgetState.hovered)) {
      return hoverStyle?.textStyle?.resolve(state);
    }

    return style?.textStyle?.resolve(state);
  }

  Color? _overlayColor(Set<WidgetState> state) {
    if (isActive) {
      return activeStyle?.overlayColor?.resolve(state);
    }

    if (state.contains(WidgetState.hovered)) {
      return hoverStyle?.overlayColor?.resolve(state);
    }

    return style?.overlayColor?.resolve(state);
  }

  Color? _foregroundColor(Set<WidgetState> state) {
    if (isActive) {
      return activeStyle?.foregroundColor?.resolve(state);
    }

    if (state.contains(WidgetState.hovered)) {
      return hoverStyle?.foregroundColor?.resolve(state);
    }

    return style?.foregroundColor?.resolve(state);
  }

  EdgeInsetsGeometry? _padding(Set<WidgetState> state) {
    if (isActive) {
      return activeStyle?.padding?.resolve(state);
    }

    if (state.contains(WidgetState.hovered)) {
      return hoverStyle?.padding?.resolve(state);
    }

    return style?.padding?.resolve(state);
  }

  Size? _minimumSize(Set<WidgetState> state) {
    if (isActive) {
      return activeStyle?.minimumSize?.resolve(state);
    }

    if (state.contains(WidgetState.hovered)) {
      return hoverStyle?.minimumSize?.resolve(state);
    }

    return style?.minimumSize?.resolve(state);
  }
}
