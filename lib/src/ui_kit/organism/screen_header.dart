import 'package:flutter/material.dart';

import '../atoms/fonts.dart';

class ScreenHeader extends StatelessWidget {
  final Text text;

  const ScreenHeader({super.key, required this.text});

  static const _padding = EdgeInsets.only(top: 40.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: DefaultTextStyle.merge(
        style: CvAppFonts.header,
        child: text,
      ),
    );
  }
}
