import 'package:flutter/material.dart';

import 'src.dart';
import 'features/features.dart';

class ScaffoldCvApp extends StatelessWidget {
  final Widget child;

  const ScaffoldCvApp({
    super.key,
    required this.child,
  });

  static const _appConstraints = BoxConstraints(maxWidth: 1366.0);
  static const _appPadding = EdgeInsets.symmetric(horizontal: 40.0);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CvAppLanguageState>(
      stream: injector<CvAppLanguageController>().stream,
      builder: (context, snapshot) {
        final lang =
            snapshot.data?.cvAppLanguage.code ?? injector<CvAppLanguageState>().cvAppLanguage.code;

        injector<CvAppMenuController>().loadItems(lang);
        injector<WelcomeScreenController>().loadData(lang);

        return Container(
          alignment: Alignment.center,
          color: CvAppBasicColors.gloomy,
          padding: _appPadding,
          child: ConstrainedBox(
            constraints: _appConstraints,
            child: Scaffold(
              appBar: const CvAppBar(),
              body: child,
            ),
          ),
        );
      },
    );
  }
}
