import 'package:flutter/material.dart';

import '../molecules/button.dart';

class ErrorPlaceholder extends StatelessWidget {
  final Text? message;
  final Widget childButton;
  final void Function()? onPressed;

  const ErrorPlaceholder({
    super.key,
    this.message,
    this.onPressed,
    required this.childButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        if (message != null) ...[
          message!,
          const SizedBox(height: 40.0),
        ],
        Center(
          child: SizedBox(
            width: 180,
            child: CvAppButton.primary(
              onPressed: onPressed,
              child: childButton,
            ),
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
