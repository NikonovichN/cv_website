import 'package:flutter/material.dart';

import '../../common/values.dart';

class ScrollScreenConfiguration extends StatelessWidget {
  final Widget child;

  const ScrollScreenConfiguration({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final isSmallScreen = widthScreen < appConstraints.maxWidth;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: isSmallScreen),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
