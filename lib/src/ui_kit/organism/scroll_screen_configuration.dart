import 'package:flutter/material.dart';

class ScrollScreenConfiguration extends StatelessWidget {
  final Widget child;

  const ScrollScreenConfiguration({super.key, required this.child});

  static const _padding = EdgeInsets.symmetric(vertical: 20.0);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        padding: _padding,
        child: child,
      ),
    );
  }
}
