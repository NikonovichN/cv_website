import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:cv_website/src/assets/assets.gen.dart';

import '../../di/injections.dart';
import '../../ui_kit/ui_kit.dart';
import '../../managers/firebase_analytics.dart';
import '../../navigation/paths.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final errorEvent = ErrorEventParameters(message: RouterPath.error.name);
    injector<FirebaseAnalytics>().logEvent(name: errorEvent.name, parameters: errorEvent.toMap());

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
