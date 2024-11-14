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

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: ButtonStyle(
        textStyle: WidgetStateTextStyle.resolveWith(_textStyle),
      ),
      child: child,
    );
  }

  // TODO: to think about better solution with resolver
  TextStyle _textStyle(Set<WidgetState> state) {
    TextStyle textStyle = const TextStyle();

    if (isActive) {
      return activeStyle?.textStyle?.resolve(state) ?? textStyle;
    }

    if (state.contains(WidgetState.hovered)) {
      return hoverStyle?.textStyle?.resolve(state) ?? textStyle;
    }

    return style?.textStyle?.resolve(state) ?? textStyle;
  }
}
