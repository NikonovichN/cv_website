import 'package:cv_website/src/ui_kit/atoms/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:cv_website/src/assets/assets.gen.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        Assets.icons.svg.oops,
        width: 140.0,
        colorFilter: const ColorFilter.mode(
          CvAppBasicColors.greenLight,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
